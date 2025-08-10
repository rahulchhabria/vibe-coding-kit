#!/usr/bin/env bash
set -euo pipefail

# Cross-platform notification helper
notify() {
  local title="$1"
  local message="$2"
  local sound="${3:-}"
  
  if [[ "$(uname -s)" == "Darwin" ]]; then
    # macOS: Use osascript for notifications
    osascript -e "display notification \"$message\" with title \"$title\"" 2>/dev/null || true
    if [[ -n "$sound" ]]; then
      afplay "/System/Library/Sounds/$sound.aiff" 2>/dev/null || true
    fi
  elif command -v notify-send >/dev/null 2>&1; then
    # Linux: Use notify-send if available
    notify-send "$title" "$message" 2>/dev/null || true
    if [[ -n "$sound" ]] && command -v paplay >/dev/null 2>&1; then
      paplay "/usr/share/sounds/freedesktop/stereo/$sound.oga" 2>/dev/null || true
    fi
  elif [[ -n "$WINDOWS_HOST" ]] || [[ "$(uname -r)" == *"microsoft"* ]]; then
    # WSL: Use PowerShell for Windows notifications
    powershell.exe -Command "
      Add-Type -AssemblyName System.Windows.Forms
      \$notification = New-Object System.Windows.Forms.NotifyIcon
      \$notification.Icon = [System.Drawing.SystemIcons]::Information
      \$notification.BalloonTipIcon = 'Info'
      \$notification.BalloonTipTitle = '$title'
      \$notification.BalloonTipText = '$message'
      \$notification.Visible = \$true
      \$notification.ShowBalloonTip(5000)
    " 2>/dev/null || true
  fi
  
  # Always log to console as fallback
  echo "[$title] $message"
}

# Export for use in other scripts
export -f notify

# If called directly with arguments
if [[ $# -ge 2 ]]; then
  notify "$@"
fi