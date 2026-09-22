#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="${1:-}"

if [ -z "$APP" ]; then
  echo "Usage: bash scripts/start.sh <app>"
  exit 1
fi

if [ -d "$ROOT/apps/$APP" ]; then
  echo "Starting $APP..."
  cd "$ROOT/apps/$APP"

  if [ -f package.json ]; then
    npm run dev
  elif [ -f go.mod ]; then
    go run .
  else
    echo "No recognized project startup method for $APP"
  fi
else
  echo "App not found: $APP"
fi
