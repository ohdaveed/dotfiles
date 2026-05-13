#!/usr/bin/env bash
# Install the Vercel CLI globally via npm.
# Idempotent: no-op if already installed.
set -euo pipefail

# Bootstrap fnm so `npm` is available.
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

if command -v vercel &>/dev/null; then
  echo "Vercel CLI already installed: $(vercel --version 2>/dev/null || true)"
  exit 0
fi

npm install -g vercel
