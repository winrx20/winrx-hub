#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PID_DIR="$ROOT/.runtime/pids"
LOG_DIR="$ROOT/.runtime/logs"
mkdir -p "$PID_DIR" "$LOG_DIR"

command -v python3 >/dev/null 2>&1 || { echo "python3 is required" >&2; exit 1; }

# Production mode is intentionally explicit: it starts only apps with production=true.
python3 - "$ROOT/registry.json" <<'PY'
import json, subprocess, sys
registry = json.load(open(sys.argv[1], encoding="utf-8"))
for name, app in registry.get("apps", {}).items():
    if app.get("enabled", False) and app.get("production", False):
        print(f"Starting production app: {name}")
        subprocess.run([str(sys.argv[0]).replace("production.sh", "../bin/winrx"), "start", name], check=False)
PY

echo "Production apps started. Use 'winrx health' and 'winrx logs <app>' to inspect them."
