#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "WinRX Hub status"
echo "Root: $ROOT"

if [ -d "$ROOT/apps" ]; then
  echo "Apps:"
  ls -1 "$ROOT/apps"
fi
