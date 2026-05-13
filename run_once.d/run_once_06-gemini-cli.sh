#!/usr/bin/env bash
set -euo pipefail

if ! pipx list | grep -q google-generativeai; then
  pipx install google-generativeai
fi
