#!/usr/bin/env bash
# Install the latest LTS Node.js via fnm, then install global npm tools.
# Idempotent: fnm install is safe to re-run; npm install -g skips if current.
set -euo pipefail

# Bootstrap fnm into this shell session.
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

# Install & use the latest LTS Node.
fnm install --lts
fnm use lts-latest
fnm default lts-latest

# Global npm tools.
npm install -g --prefer-dedupe \
  pnpm \
  nodemon \
  vite
