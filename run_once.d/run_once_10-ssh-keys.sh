#!/usr/bin/env bash
set -euo pipefail

SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/id_ed25519"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ ! -f "$KEY_PATH" ]; then
  ssh-keygen -t ed25519 -C "{{ .email }}" -f "$KEY_PATH" -N ""
fi

chmod 600 "$KEY_PATH"
chmod 644 "$KEY_PATH.pub"
