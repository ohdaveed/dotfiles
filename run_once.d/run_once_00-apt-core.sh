#!/usr/bin/env bash
# Install core apt packages needed by the rest of the setup.
# Idempotent: apt-get install is safe to re-run.
set -euo pipefail

sudo apt-get update -qq

sudo apt-get install -y --no-install-recommends \
  git \
  curl \
  wget \
  unzip \
  build-essential \
  ca-certificates \
  gnupg \
  lsb-release \
  zsh \
  jq \
  xsel \
  xdg-utils \
  wslu
