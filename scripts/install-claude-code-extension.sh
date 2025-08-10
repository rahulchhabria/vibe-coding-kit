#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=_lib.sh
source "$SCRIPT_DIR/_lib.sh"

# Claude Code extension IDs (these can change; include variants)
# VS Code marketplace: anthropic.claude-copilot or variety of forks
CLAUDE_IDS=(
  "anthropic.claude-copilot"
  "anthropic.claude-code"
  "anthropic.claude-dev"
)

cursor_cli="$(find_cursor_cli)"
vscode_cli="$(find_vscode_cli)"

if [[ -n "$cursor_cli" ]]; then
  log "Trying to install Claude extension into Cursor..."
  if install_extension_with_any_id "$cursor_cli" "${CLAUDE_IDS[@]}"; then
    ok "Claude extension installed in Cursor."
  else
    warn "Failed to install Claude extension into Cursor."
  fi
else
  warn "Cursor CLI not found. Skipping Cursor."
fi

if [[ -n "$vscode_cli" ]]; then
  log "Trying to install Claude extension into VS Code..."
  if install_extension_with_any_id "$vscode_cli" "${CLAUDE_IDS[@]}"; then
    ok "Claude extension installed in VS Code."
  else
    warn "Failed to install Claude extension into VS Code."
  fi
else
  warn "VS Code CLI not found. Skipping VS Code."
fi
