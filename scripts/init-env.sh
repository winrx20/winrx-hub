#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_DIR="$ROOT/.env.d"
mkdir -p "$ENV_DIR"

cat > "$ENV_DIR/README.md" <<'EOF'
# Per-app environment files

Store local environment configuration for each app here.

Files are intentionally not committed to the repo by default.

Example:
- 9router.env
- docs.env
- SeeStack.env

Use shell-export format:
PORT=3000
API_KEY=your-local-key
EOF

cat > "$ENV_DIR/.gitignore" <<'EOF'
*
!.gitignore
!README.md
EOF

echo "Per-app environment directory initialized at $ENV_DIR"
