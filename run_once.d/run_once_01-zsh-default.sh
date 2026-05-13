#!/usr/bin/env bash
# Install the Zap plugin manager and set zsh as the default shell.
# Idempotent: checks guard files before acting.
set -euo pipefail

ZSH_BIN="$(command -v zsh)"

# Make zsh the default shell if it is not already.
if [ "$SHELL" != "$ZSH_BIN" ]; then
  if ! grep -qxF "$ZSH_BIN" /etc/shells; then
    echo "$ZSH_BIN" | sudo tee -a /etc/shells
  fi
  sudo chsh -s "$ZSH_BIN" "$USER"
fi

# Install Zap (zsh plugin manager) if not already installed.
ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
if [ ! -d "$ZAP_DIR" ]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) \
    --branch release-v1 --keep
fi
