#!/usr/bin/env bash
# Generate an ed25519 SSH key if none exists.
# Idempotent: skips generation when ~/.ssh/id_ed25519 is already present.
set -euo pipefail

KEY="$HOME/.ssh/id_ed25519"

if [ -f "$KEY" ]; then
  echo "SSH key already exists at $KEY — skipping."
  exit 0
fi

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Use git email if configured, otherwise fall back to user@hostname.
EMAIL="$(git config --global user.email 2>/dev/null || echo "${USER}@$(hostname -f)")"

ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY" -N ""

echo ""
echo "SSH key generated. Public key:"
cat "${KEY}.pub"
echo ""
echo "Add this key to GitHub: https://github.com/settings/keys"
