#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$ROOT/apps" "$ROOT/scripts" "$ROOT/bin"

if [ ! -f "$ROOT/.env" ]; then
  cp "$ROOT/.env.example" "$ROOT/.env"
fi

if [ ! -f "$ROOT/bin/winrx" ]; then
  echo "The launcher script is missing. Please re-run setup or restore bin/winrx."
  exit 1
fi

chmod +x "$ROOT/scripts"/*.sh 2>/dev/null || true
chmod +x "$ROOT/bin/winrx" 2>/dev/null || true

echo "WinRX Hub installed successfully."
echo "Run: export PATH=\"$ROOT/bin:\$PATH\""
echo "Then: winrx status"
