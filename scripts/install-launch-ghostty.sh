#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=_lib.sh
source "$SCRIPT_DIR/_lib.sh"

ensure_homebrew

if app_exists "Ghostty"; then
  ok "Ghostty already installed. Launching..."
  launch_app "Ghostty"
  exit 0
fi

# Try Homebrew cask
if [[ "$(uname -s)" == "Darwin" ]]; then
  log "Installing Ghostty via Homebrew cask..."
  brew_install_cask_if_missing "ghostty"
  ok "Installed Ghostty. Launching..."
  launch_app "Ghostty"
  exit 0
fi

warn "Non-macOS install path not implemented."
