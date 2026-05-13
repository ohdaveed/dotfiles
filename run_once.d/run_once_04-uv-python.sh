#!/usr/bin/env bash
# Install uv (Astral's Python package manager) and the Python version needed
# by Claude CLI.
# Idempotent: checks guard files before each action.
set -euo pipefail

# Install uv if not present.
if ! command -v uv &>/dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Make uv available in this session.
export PATH="$HOME/.local/bin:$PATH"

# Install Python 3.11 via uv (required by Claude CLI's Python SDK).
PYTHON_VERSION="3.11"
if ! uv python list --only-installed 2>/dev/null | grep -q "cpython-${PYTHON_VERSION}"; then
  uv python install "$PYTHON_VERSION"
fi
