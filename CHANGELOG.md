# Changelog

## [1.0.0] - 2025-01-10

### Added
- Complete Stream Deck Mini integration with 6 pre-configured buttons
- Stream Deck profile file (`.streamDeckProfile`) for automatic import
- Comprehensive README with setup instructions and troubleshooting
- Cross-platform notification system (macOS, Linux, WSL)
- Enhanced error handling and user feedback in all scripts
- Windows batch file wrappers for native Windows support
- Installation helper script (`install.sh`) with platform detection
- Icon generation tool (`tools/generate-icon.sh`)
- Git ignore file for clean repository
- Changelog documentation

### Improved
- Added error handling to all URL opening and app launching functions
- Enhanced `_lib.sh` with notification support and better error messages
- Added platform detection for WSL/Windows support
- Improved scripts with trap handlers for better error reporting

### Platform Support
- **macOS**: Full native support with notifications
- **Linux**: Support via xdg-open and notify-send
- **Windows**: Native batch files + WSL wrapper support

### Scripts Included
1. `open-sentry.sh` - Opens Sentry.io monitoring dashboard
2. `open-bolt.sh` - Opens Bolt.new for rapid prototyping
3. `open-chatgpt.sh` - Opens ChatGPT interface
4. `install-launch-ghostty.sh` - Installs/launches Ghostty terminal
5. `install-launch-cursor.sh` - Installs/launches Cursor editor
6. `install-claude-code-extension.sh` - Installs Claude VS Code extension