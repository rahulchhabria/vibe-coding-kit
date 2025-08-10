#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=_lib.sh
source "$SCRIPT_DIR/_lib.sh"

ensure_homebrew

if app_exists "Cursor"; then
  ok "Cursor already installed. Launching..."
  launch_app "Cursor"
  exit 0
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  log "Installing Cursor via Homebrew cask..."
  brew_install_cask_if_missing "cursor"
  ok "Installed Cursor. Launching..."
  launch_app "Cursor"
  exit 0
fi

warn "Non-macOS install path not implemented."
