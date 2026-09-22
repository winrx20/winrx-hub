#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="${1:-}"
PORT="${2:-3000}"
LOG_DIR="$ROOT/.runtime/logs"
PID_DIR="$ROOT/.runtime/pids"
mkdir -p "$LOG_DIR" "$PID_DIR"

if [ -z "$APP" ]; then
  echo "Usage: bash scripts/run-production.sh <app> <port>"
  exit 1
fi

APP_PATH="$ROOT/apps/$APP"
if [ ! -d "$APP_PATH" ]; then
  echo "App not found: $APP_PATH"
  exit 1
fi

ENV_FILE="$ROOT/.env.d/${APP}.env"
if [ -f "$ENV_FILE" ]; then
  set -a
  . "$ENV_FILE"
  set +a
fi

LOG_PATH="$LOG_DIR/${APP}.log"
PID_PATH="$PID_DIR/${APP}.pid"

if [ -f "$PID_PATH" ] && kill -0 "$(cat "$PID_PATH")" 2>/dev/null; then
  echo "$APP is already running with PID $(cat "$PID_PATH")"
  exit 0
fi

cd "$APP_PATH"
nohup sh -lc "PORT=${PORT} npm run start" >> "$LOG_PATH" 2>&1 &
echo $! > "$PID_PATH"

echo "Started $APP on port ${PORT}"
echo "PID: $(cat "$PID_PATH")"
