#!/usr/bin/env bash
# Install the Anthropic Claude CLI (@anthropic-ai/claude-code) globally via npm.
# Idempotent: no-op if already installed.
set -euo pipefail

# Bootstrap fnm so `npm` is available.
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

if command -v claude &>/dev/null; then
  echo "Claude CLI already installed: $(claude --version 2>/dev/null || true)"
  exit 0
fi

npm install -g @anthropic-ai/claude-code
