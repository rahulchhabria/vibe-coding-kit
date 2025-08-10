#!/usr/bin/env bash
set -euo pipefail

# Vibe Coding Kit installer with Stream Deck integration

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$ROOT_DIR/scripts"

# Source library
source "$SCRIPTS_DIR/_lib.sh"

cat << "EOF"
╔══════════════════════════════════════╗
║     Vibe Coding Kit for Stream Deck  ║
║          Installation Script          ║
╚══════════════════════════════════════╝
EOF

log "Starting installation..."

# 1. Check platform
PLATFORM="unknown"
if [[ "$(uname -s)" == "Darwin" ]]; then
  PLATFORM="macos"
  ok "Detected macOS"
elif [[ "$(uname -s)" == "Linux" ]]; then
  PLATFORM="linux"
  ok "Detected Linux"
elif [[ -n "${WINDOWS_HOST:-}" ]] || [[ "$(uname -r)" == *"microsoft"* ]]; then
  PLATFORM="wsl"
  ok "Detected Windows WSL"
fi

# 2. Make scripts executable
log "Setting script permissions..."
chmod +x "$SCRIPTS_DIR"/*.sh
chmod +x "$ROOT_DIR/setup.sh"
if [[ -f "$ROOT_DIR/tools/generate-icon.sh" ]]; then
  chmod +x "$ROOT_DIR/tools/generate-icon.sh"
fi
ok "Scripts made executable"

# 3. Run setup
log "Running setup..."
"$ROOT_DIR/setup.sh"

# 4. Platform-specific instructions
echo ""
echo "════════════════════════════════════════"
echo "STREAM DECK CONFIGURATION"
echo "════════════════════════════════════════"

if [[ "$PLATFORM" == "macos" ]]; then
  cat << EOF

macOS Setup:
1. Open Stream Deck software
2. Go to Preferences → Profiles → Import
3. Select: $ROOT_DIR/Vibe-Coding-Kit.streamDeckProfile
4. The profile will map all 6 buttons automatically

Alternative manual setup:
- Drag "System → Open" action to each button
- Set App/File to scripts in: $SCRIPTS_DIR/
- Set icons from: $ROOT_DIR/icons/

EOF
elif [[ "$PLATFORM" == "linux" ]]; then
  cat << EOF

Linux Setup:
1. Ensure Stream Deck software is installed
2. Import profile: $ROOT_DIR/Vibe-Coding-Kit.streamDeckProfile
3. Or manually map scripts from: $SCRIPTS_DIR/

Note: Some features may require additional packages:
- notify-send for notifications
- xdg-open for opening URLs

EOF
elif [[ "$PLATFORM" == "wsl" ]]; then
  cat << EOF

Windows Setup:
1. Open Stream Deck software on Windows
2. For native Windows support, use batch files in: $ROOT_DIR/windows/
3. For WSL support, point to scripts via WSL path:
   \\\\wsl$\\Ubuntu\\path\\to\\vibe-coding-kit\\scripts\\

Alternative: Use the provided batch wrappers in windows/ folder

EOF
fi

# 5. Test notification
if declare -f notify >/dev/null; then
  notify "Vibe Coding Kit" "Installation complete!" "Glass"
fi

ok "Installation complete!"
echo ""
echo "Need help? Check the README.md for detailed instructions."