#!/usr/bin/env bash
set -euo pipefail

if command -v zsh >/dev/null 2>&1; then
  if [ "${SHELL:-}" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)" "$USER" || true
  fi
fi

if [ ! -d "$HOME/.local/share/zap" ]; then
  sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
fi
