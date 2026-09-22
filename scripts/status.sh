#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -f "$ROOT/scripts/status.sh" ]; then
  bash "$ROOT/scripts/status.sh" "$@"
else
  echo "Status script missing."
fi
