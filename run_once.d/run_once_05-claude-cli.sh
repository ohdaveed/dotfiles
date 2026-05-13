#!/usr/bin/env bash
set -euo pipefail

if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://install.anthropic.com/claude/install.sh | sh
fi
