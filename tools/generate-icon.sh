#!/usr/bin/env bash
set -euo pipefail

# Icon generation helper tool
# Usage: ./tools/generate-icon.sh "Label" "filename.png" "#hexcolor"

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ICONS_DIR="$ROOT_DIR/icons"

# Source library
source "$ROOT_DIR/scripts/_lib.sh"

if [[ $# -lt 3 ]]; then
  fail "Usage: $0 <label> <filename> <hex-color>"
fi

label="$1"
filename="$2"
bg_color="$3"
text_color="${4:-#ffffff}"

mkdir -p "$ICONS_DIR"

if [[ -f "$ICONS_DIR/$filename" ]]; then
  warn "Icon $filename already exists. Use -f to overwrite."
  exit 0
fi

if ! is_command convert; then
  fail "ImageMagick not installed. Run: brew install imagemagick"
fi

log "Generating icon: $filename"

convert -size 512x512 xc:"$bg_color" \
  -gravity center \
  -font Helvetica-Bold -pointsize 96 -fill "$text_color" \
  -annotate 0 "$label" \
  "$ICONS_DIR/$filename"

ok "Generated icon: $ICONS_DIR/$filename"