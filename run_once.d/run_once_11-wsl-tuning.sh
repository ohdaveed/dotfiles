#!/usr/bin/env bash
# Apply WSL-specific performance and interop tweaks.
# Idempotent: each block checks before modifying.
set -euo pipefail

WSLCONF="/etc/wsl.conf"

# Only run inside WSL.
if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ] && ! grep -qi microsoft /proc/version 2>/dev/null; then
  echo "Not running under WSL — skipping."
  exit 0
fi

# ── /etc/wsl.conf ────────────────────────────────────────────────────────────
# Write a safe wsl.conf if the desired section is not already present.
if ! sudo grep -q '^\[interop\]' "$WSLCONF" 2>/dev/null; then
  sudo tee -a "$WSLCONF" > /dev/null <<'EOF'

[interop]
appendWindowsPath = false

[boot]
systemd = true

[network]
generateHosts = true
generateResolvConf = true
EOF
  echo "wsl.conf updated — restart WSL (wsl --shutdown) to apply."
fi

# ── ~/.wslconfig (Windows-side limits) ───────────────────────────────────────
WSLCONFIG="$HOME/.wslconfig"
if [ ! -f "$WSLCONFIG" ]; then
  cat > "$WSLCONFIG" <<'EOF'
[wsl2]
memory=8GB
processors=4
swap=2GB
localhostForwarding=true
EOF
  echo ".wslconfig written to $WSLCONFIG"
fi

# ── Disable case-insensitive filesystem FS flag warnings ─────────────────────
# Silence the common "wsl: Permissions for ... are too open" warning by
# setting the correct permissions on the SSH directory if it exists.
if [ -d "$HOME/.ssh" ]; then
  chmod 700 "$HOME/.ssh"
  find "$HOME/.ssh" -type f -exec chmod 600 {} +
  find "$HOME/.ssh" -name "*.pub" -exec chmod 644 {} +
fi
