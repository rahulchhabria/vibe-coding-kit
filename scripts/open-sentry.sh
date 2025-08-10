#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=_lib.sh
source "$SCRIPT_DIR/_lib.sh"

# Error handling and feedback
trap 'warn "Failed to open Sentry"; exit 1' ERR

open_url "https://sentry.io" "Sentry" || exit 1