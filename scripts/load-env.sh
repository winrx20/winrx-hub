#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="${1:-}"
ENV_FILE="$ROOT/.env.d/${APP}.env"

if [ -z "$APP" ]; then
  echo "Usage: bash scripts/load-env.sh <app>"
  exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "No environment file found for $APP: $ENV_FILE"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

echo "Loaded environment for $APP from $ENV_FILE"
