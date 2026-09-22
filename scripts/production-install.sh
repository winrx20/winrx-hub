#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  cat <<'EOF'
WinRX production helper

Usage:
  bash scripts/production-install.sh

This installs the hub as a user-level service when systemd is available.
On Termux, use scripts/install-termux-boot.sh instead.
EOF
  exit 0
fi

if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemd is not available. For Termux, run: bash scripts/install-termux-boot.sh"
  exit 0
fi

SERVICE_DIR="$HOME/.config/systemd/user"
mkdir -p "$SERVICE_DIR"
cat > "$SERVICE_DIR/winrx-hub.service" <<EOF
[Unit]
Description=WinRX Hub production services
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
WorkingDirectory=$ROOT
ExecStart=$ROOT/scripts/production.sh
RemainAfterExit=yes
ExecStop=$ROOT/bin/winrx stop all

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now winrx-hub.service
systemctl --user status winrx-hub.service --no-pager || true

echo "Installed user service: winrx-hub.service"
