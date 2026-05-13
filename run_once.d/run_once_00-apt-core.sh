#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y \
  git \
  curl \
  unzip \
  build-essential \
  zsh \
  wslu \
  python3 \
  python3-pip \
  python3-venv \
  pipx

pipx ensurepath || true
