#!/usr/bin/env bash
set -e
APP="${1:-}"
if [ -z "$APP" ]; then
  echo "Usage: bash scripts/stop.sh <app>"
  exit 1
fi

echo "Stopping $APP..."
echo "Add project-specific stop logic if needed."
