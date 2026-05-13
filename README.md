# Dotfiles (WSL‑First)

This repository contains a deterministic, idempotent bootstrap system for my WSL development environment using Chezmoi.

## Features
- zsh + Zap plugin manager
- fnm (Fast Node Manager)
- Node LTS + pnpm + nodemon + vite + vercel
- bun runtime
- uv + Python 3.12 (Claude‑compatible)
- Claude CLI
- Gemini CLI (pipx)
- GitHub CLI
- SSH key generation
- WSL tuning (systemd, DNS, interop)
- Fully templated dotfiles (zshrc, gitconfig, ssh config)

## Install (fresh WSL)
```bash
sudo apt update && sudo apt install -y git curl
git clone https://github.com/ohdaveed/dotfiles.git "$HOME/dotfiles"
chezmoi init --source="$HOME/dotfiles" --apply
```
