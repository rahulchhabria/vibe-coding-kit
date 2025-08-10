#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$ROOT_DIR/scripts"
ICONS_DIR="$ROOT_DIR/icons"

# shellcheck source=scripts/_lib.sh
source "$SCRIPTS_DIR/_lib.sh"

log "Setting up Vibe Code Kit..."

ensure_homebrew

# Core CLIs used by scripts
if [[ "$(uname -s)" == "Darwin" ]]; then
  brew update
  brew_install_if_missing "imagemagick" # for icon generation
fi

# Generate basic icons if not present
mkdir -p "$ICONS_DIR"

generate_icon() {
  local label="$1"; shift
  local filename="$1"; shift
  local bg_color="$1"; shift
  local text_color="#ffffff"

  if [[ -f "$ICONS_DIR/$filename" ]]; then return 0; fi
  if ! is_command convert; then warn "ImageMagick 'convert' not installed; skipping icon generation for $label"; return 0; fi

  convert -size 512x512 xc:"$bg_color" \
    -gravity center \
    -font Helvetica -pointsize 96 -fill "$text_color" -annotate 0 "$label" \
    "$ICONS_DIR/$filename"
  ok "Generated icon $filename"
}

# Simple letter icons as placeholders
generate_icon "S" "sentry.png" "#18181b"
generate_icon "B" "bolt.png"   "#0ea5e9"
generate_icon "G" "chatgpt.png" "#10b981"
generate_icon "T" "ghostty.png" "#0f172a"
generate_icon "C" "cursor.png"  "#f59e0b"
generate_icon "A" "claude.png"  "#7c3aed"

ok "Setup complete. You can now assign scripts to Stream Deck buttons."

cat <<EOF
Next steps:
- Map these scripts in your Stream Deck software:
  - $SCRIPTS_DIR/open-sentry.sh
  - $SCRIPTS_DIR/open-bolt.sh
  - $SCRIPTS_DIR/open-chatgpt.sh
  - $SCRIPTS_DIR/install-launch-ghostty.sh
  - $SCRIPTS_DIR/install-launch-cursor.sh
  - $SCRIPTS_DIR/install-claude-code-extension.sh
- Use matching icons from: $ICONS_DIR
EOF
