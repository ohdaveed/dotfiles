#!/usr/bin/env bash
# Install fnm (Fast Node Manager).
# Idempotent: no-op if fnm is already on PATH.
set -euo pipefail

if command -v fnm &>/dev/null; then
  echo "fnm already installed: $(fnm --version)"
  exit 0
fi

curl -fsSL https://fnm.vercel.app/install | bash

# Make fnm available in the current session so subsequent scripts can use it.
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"
