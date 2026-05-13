#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

fnm install --lts
fnm default lts-latest

npm install -g pnpm nodemon vite vercel
