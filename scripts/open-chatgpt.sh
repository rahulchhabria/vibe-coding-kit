#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=_lib.sh
source "$SCRIPT_DIR/_lib.sh"

# Error handling and feedback
trap 'warn "Failed to open ChatGPT"; exit 1' ERR

open_url "https://chat.openai.com" "ChatGPT" || exit 1