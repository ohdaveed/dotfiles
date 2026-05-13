#!/usr/bin/env bash
# Install the Google Gemini CLI (@google/gemini-cli) globally via npm.
# Idempotent: no-op if already installed.
set -euo pipefail

# Bootstrap fnm so `npm` is available.
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

if command -v gemini &>/dev/null; then
  echo "Gemini CLI already installed: $(gemini --version 2>/dev/null || true)"
  exit 0
fi

npm install -g @google/gemini-cli
