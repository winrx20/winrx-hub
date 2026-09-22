#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/.runtime/pids" "$ROOT/.runtime/logs"

python3 - "$ROOT/registry.json" <<'PY'
import json, os, subprocess, sys
registry = json.load(open(sys.argv[1], encoding='utf-8'))
for name, app in registry.get('apps', {}).items():
    if app.get('enabled', False):
        path = os.path.join(os.getcwd(), app['path'])
        env_file = os.path.join(os.getcwd(), '.env.d', f"{name}.env")
        pid_file = os.path.join(os.getcwd(), '.runtime', 'pids', f"{name}.pid")
        log_file = os.path.join(os.getcwd(), '.runtime', 'logs', f"{name}.log")
        print(f"{name}: checking repo at {path}")
        if os.path.isdir(path):
            print(f"{name}: repo available")
        else:
            print(f"{name}: missing repo -> run bootstrap.sh")
        if os.path.exists(env_file):
            print(f"{name}: env file found")
        else:
            print(f"{name}: no env file found")
        if os.path.exists(pid_file):
            print(f"{name}: pid file present")
PY

echo "Health check finished."
