# Vibe Coding Kit for Stream Deck

A collection of productivity scripts and shortcuts optimized for the Elgato Stream Deck Mini, designed to streamline your development workflow.

## 🎯 Features

- **6 Pre-configured Actions** perfect for Stream Deck Mini's 6-button layout
- **Auto-generated Icons** with consistent styling
- **Cross-platform Support** (macOS primary, Linux support, Windows via WSL)
- **One-click Setup** with automatic dependency installation
- **Stream Deck Profile** included for instant import

## 📦 What's Included

| Button | Script | Function |
|--------|--------|----------|
| 1 | `open-sentry.sh` | Opens Sentry.io in your browser |
| 2 | `open-bolt.sh` | Opens Bolt.new for rapid prototyping |
| 3 | `open-chatgpt.sh` | Opens ChatGPT in your browser |
| 4 | `install-launch-ghostty.sh` | Installs/launches Ghostty terminal |
| 5 | `install-launch-cursor.sh` | Installs/launches Cursor editor |
| 6 | `install-claude-code-extension.sh` | Installs Claude extension in VS Code/Cursor |

## 🚀 Quick Start

### Prerequisites

- Elgato Stream Deck Mini (or any Stream Deck model)
- [Stream Deck Software](https://www.elgato.com/downloads)
- macOS, Linux, or Windows with WSL

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/vibe-coding-kit.git
   cd vibe-coding-kit
   ```

2. **Run the setup script:**
   ```bash
   ./setup.sh
   ```
   This will:
   - Install required dependencies (Homebrew on macOS, ImageMagick)
   - Generate icon files for all buttons
   - Prepare all scripts for execution

3. **Import the Stream Deck profile:**
   - Open Stream Deck software
   - Go to Preferences → Profiles
   - Click the down arrow → Import
   - Select `Vibe-Coding-Kit.streamDeckProfile` from this repo
   - The profile will automatically map all 6 buttons

### Manual Setup (Alternative)

If you prefer to set up buttons manually:

1. Open Stream Deck software
2. Drag a "System: Open" action to each button
3. For each button, set:
   - **App/File:** Navigate to the corresponding script in `scripts/` folder
   - **Icon:** Use the matching icon from `icons/` folder

## 🎨 Customization

### Modifying Scripts

All scripts are in the `scripts/` directory. Feel free to modify them for your needs:

```bash
# Example: Change ChatGPT to Claude
vim scripts/open-chatgpt.sh
# Change the URL to https://claude.ai
```

### Regenerating Icons

Icons are auto-generated with text labels. To customize:

1. Edit `setup.sh` and modify the `generate_icon` calls
2. Run `./setup.sh` again to regenerate
3. Or replace with your own 512x512 PNG images in `icons/`

### Adding New Buttons

1. Create a new script in `scripts/`:
   ```bash
   cp scripts/open-chatgpt.sh scripts/open-myapp.sh
   vim scripts/open-myapp.sh
   ```

2. Generate an icon:
   ```bash
   ./tools/generate-icon.sh "M" "myapp.png" "#color"
   ```

3. Map it in Stream Deck software

## 🛠️ Troubleshooting

### Scripts not executing on Stream Deck

1. Ensure scripts have execute permissions:
   ```bash
   chmod +x scripts/*.sh
   ```

2. Check Stream Deck has necessary permissions (macOS):
   - System Preferences → Security & Privacy → Privacy → Accessibility
   - Add Stream Deck

### Icons not showing

- Ensure icons are 512x512 PNG format
- Check `icons/` directory has the generated files
- Try reimporting the profile

### Windows Support

For Windows users:
1. Install [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install)
2. Run scripts through WSL:
   ```bash
   wsl ./scripts/open-chatgpt.sh
   ```
3. Or use the included `windows/` batch file wrappers (coming soon)

## 📝 Script Details

### Core Library (`_lib.sh`)

All scripts source a common library providing:
- Logging functions (`log`, `ok`, `warn`, `fail`)
- URL opening across platforms
- Homebrew management (macOS)
- App detection and launching
- VS Code/Cursor extension management

### Error Handling

Scripts include:
- Safe error handling with `set -euo pipefail`
- Platform detection and fallbacks
- User-friendly error messages
- Non-zero exit codes on failure

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Ideas for Contributions

- Windows native support (PowerShell/batch scripts)
- Additional button actions
- Stream Deck XL/MK.2 profiles
- Alternative icon styles
- Integration with more developer tools

## 📄 License

MIT License - feel free to use and modify for your needs.

## 🙏 Acknowledgments

- Built for the developer community
- Inspired by the need for quick access to AI coding assistants
- Designed specifically for Stream Deck Mini's compact layout

## 📧 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check existing issues for solutions
- PRs welcome for improvements

---

**Note:** This is an unofficial tool and is not affiliated with Elgato, OpenAI, Anthropic, or any mentioned services.