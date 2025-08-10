#!/usr/bin/env bash
set -euo pipefail

# Source notification helper if available
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/notify.sh" ]]; then
  source "$SCRIPT_DIR/notify.sh"
fi

# Logging helpers
bold="$(tput bold 2>/dev/null || true)"
reset="$(tput sgr0 2>/dev/null || true)"

log() { echo "${bold}[vibe]${reset} $*"; }
ok() { echo "${bold}[ok]${reset} $*"; }
warn() { echo "${bold}[warn]${reset} $*"; }
fail() { echo "${bold}[fail]${reset} $*"; exit 1; }

is_command() { command -v "$1" >/dev/null 2>&1; }

# Open URL in default browser with error handling
open_url() {
  local url="$1"
  local name="${2:-URL}"
  
  log "Opening $name..."
  
  if [[ "$(uname -s)" == "Darwin" ]]; then
    if open "$url" 2>/dev/null; then
      ok "Opened $name successfully"
      if declare -f notify >/dev/null; then
        notify "Stream Deck" "Opened $name" "Glass"
      fi
      return 0
    else
      fail "Failed to open $name"
    fi
  elif is_command xdg-open; then
    if xdg-open "$url" 2>/dev/null; then
      ok "Opened $name successfully"
      if declare -f notify >/dev/null; then
        notify "Stream Deck" "Opened $name"
      fi
      return 0
    else
      fail "Failed to open $name"
    fi
  elif [[ -n "$WINDOWS_HOST" ]] || [[ "$(uname -r)" == *"microsoft"* ]]; then
    # WSL: Use Windows browser
    if cmd.exe /c start "$url" 2>/dev/null; then
      ok "Opened $name successfully"
      return 0
    else
      fail "Failed to open $name"
    fi
  else
    warn "No browser opener found. URL: $url"
    return 1
  fi
}

# Homebrew helpers (macOS)
ensure_homebrew() {
  if [[ "$(uname -s)" != "Darwin" ]]; then return 0; fi
  if ! is_command brew; then
    warn "Homebrew not found. Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for current shell
    if [[ -d "/opt/homebrew/bin" ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi
    if [[ -d "/usr/local/bin" && -x "/usr/local/bin/brew" ]]; then eval "$(/usr/local/bin/brew shellenv)"; fi
  fi
}

brew_install_if_missing() {
  local formula="$1"
  if ! brew list --formula --versions "$formula" >/dev/null 2>&1; then
    log "Installing $formula..."
    brew install "$formula"
  fi
}

brew_install_cask_if_missing() {
  local cask="$1"
  if ! brew list --cask --versions "$cask" >/dev/null 2>&1; then
    log "Installing $cask (cask)..."
    brew install --cask "$cask"
  fi
}

# App helpers
app_exists() {
  local app_name="$1" # e.g., "Cursor"
  if [[ "$(uname -s)" == "Darwin" ]]; then
    open -Ra "$app_name" >/dev/null 2>&1
  else
    return 1
  fi
}

launch_app() {
  local app_name="$1"
  
  log "Launching $app_name..."
  
  if [[ "$(uname -s)" == "Darwin" ]]; then
    if open -a "$app_name" 2>/dev/null; then
      ok "Launched $app_name successfully"
      if declare -f notify >/dev/null; then
        notify "Stream Deck" "Launched $app_name" "Glass"
      fi
      return 0
    else
      warn "Failed to launch $app_name - it may not be installed"
      return 1
    fi
  elif is_command "$app_name"; then
    # Linux: Try to run directly if it's in PATH
    if "$app_name" </dev/null >/dev/null 2>&1 &; then
      ok "Launched $app_name successfully"
      if declare -f notify >/dev/null; then
        notify "Stream Deck" "Launched $app_name"
      fi
      return 0
    else
      warn "Failed to launch $app_name"
      return 1
    fi
  else
    warn "$app_name not found or not supported on this platform"
    return 1
  fi
}

# VS Code / Cursor CLI discovery
find_cursor_cli() {
  if is_command cursor; then echo "cursor"; return 0; fi
  local app_cli="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
  if [[ -x "$app_cli" ]]; then echo "$app_cli"; return 0; fi
  echo ""
}

find_vscode_cli() {
  if is_command code; then echo "code"; return 0; fi
  local app_cli="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
  if [[ -x "$app_cli" ]]; then echo "$app_cli"; return 0; fi
  echo ""
}

install_extension_with_any_id() {
  local cli="$1"; shift
  local -a ids=("$@")
  for ext_id in "${ids[@]}"; do
    if "$cli" --install-extension "$ext_id" >/dev/null 2>&1; then
      ok "Installed extension: $ext_id via $cli"
      return 0
    fi
  done
  return 1
}
