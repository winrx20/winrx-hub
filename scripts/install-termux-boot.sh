#!/usr/bin/env bash
set -euo pipefail

# One-time Termux:Boot installation.
# Install the Termux:Boot add-on first, then run this script from the hub root.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BOOT_DIR="$HOME/.termux/boot"
mkdir -p "$BOOT_DIR"

cp "$ROOT/termux-boot/winrx-hub" "$BOOT_DIR/winrx-hub"
chmod +x "$BOOT_DIR/winrx-hub"

echo "Installed WinRX Hub auto-start script: $BOOT_DIR/winrx-hub"
echo "Reboot Termux after installing the Termux:Boot add-on."
