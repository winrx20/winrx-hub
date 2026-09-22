#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPS_DIR="$ROOT/apps"
REGISTRY="$ROOT/registry.json"

info() { printf '\033[1;36m[winrx]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }
fail() { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

command -v git >/dev/null 2>&1 || fail "git is required. Install it with: pkg install git"
command -v python3 >/dev/null 2>&1 || fail "python3 is required. Install it with: pkg install python"

mkdir -p "$APPS_DIR"

if [ -f "$ROOT/.env.example" ] && [ ! -f "$ROOT/.env" ]; then
  cp "$ROOT/.env.example" "$ROOT/.env"
fi

python3 - "$REGISTRY" "$APPS_DIR" <<'PY'
import json
import os
import subprocess
import sys

registry_path, apps_dir = sys.argv[1:]
with open(registry_path, encoding="utf-8") as file:
    registry = json.load(file)

for name, app in registry.get("apps", {}).items():
    if not app.get("autoClone", True):
        continue
    destination = os.path.join(os.path.dirname(apps_dir), app["path"])
    repo = app["repo"]
    if os.path.isdir(os.path.join(destination, ".git")):
        print(f"[winrx] Updating {name}")
        subprocess.run(["git", "-C", destination, "pull", "--ff-only"], check=False)
    elif os.path.exists(destination):
        print(f"[warn] Skipping {name}: destination exists but is not a git repo: {destination}")
    else:
        print(f"[winrx] Cloning {name}")
        os.makedirs(os.path.dirname(destination), exist_ok=True)
        subprocess.run(["git", "clone", repo, destination], check=False)
PY

chmod +x "$ROOT/bin/winrx" "$ROOT/scripts"/*.sh 2>/dev/null || true
info "Bootstrap complete. Run: export PATH=\"$ROOT/bin:\$PATH\""
info "Then run: winrx status"
