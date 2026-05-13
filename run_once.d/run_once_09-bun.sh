#!/usr/bin/env bash
# Install Bun (JavaScript runtime & package manager).
# Idempotent: no-op if already installed.
set -euo pipefail

if command -v bun &>/dev/null; then
  echo "Bun already installed: $(bun --version)"
  exit 0
fi

curl -fsSL https://bun.sh/install | bash
