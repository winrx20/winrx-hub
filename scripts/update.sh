#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="${1:-all}"

if [ "$APP" = "all" ]; then
  echo "Updating all apps..."
  find "$ROOT/apps" -maxdepth 1 -mindepth 1 -type d -print0 | while IFS= read -r -d '' d; do
    name="$(basename "$d")"
    if [ -d "$d/.git" ]; then
      echo "Updating $name..."
      git -C "$d" pull --ff-only || true
    else
      echo "Skipping $name: not a git repository"
    fi
  done
else
  if [ -d "$ROOT/apps/$APP/.git" ]; then
    echo "Updating $APP..."
    git -C "$ROOT/apps/$APP" pull --ff-only || true
  else
    echo "App not found or not a git repo: $APP"
    exit 1
  fi
fi
