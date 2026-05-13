#!/usr/bin/env bash
# Install the GitHub CLI (gh) via the official apt repository.
# Idempotent: no-op if already installed.
set -euo pipefail

if command -v gh &>/dev/null; then
  echo "gh already installed: $(gh --version | head -1)"
  exit 0
fi

# Add the GitHub CLI apt repo.
GH_KEYRING="/usr/share/keyrings/githubcli-archive-keyring.gpg"
if [ ! -f "$GH_KEYRING" ]; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of="$GH_KEYRING"
  sudo chmod go+r "$GH_KEYRING"
fi

GH_LIST="/etc/apt/sources.list.d/github-cli.list"
if [ ! -f "$GH_LIST" ]; then
  echo "deb [arch=$(dpkg --print-architecture) signed-by=${GH_KEYRING}] https://cli.github.com/packages stable main" \
    | sudo tee "$GH_LIST" > /dev/null
  sudo apt-get update -qq
fi

sudo apt-get install -y gh
