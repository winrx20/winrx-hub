# Production hardening plan

## 1. Per-app environment files

Run:

```bash
bash scripts/init-env.sh
```

Then create files like:

```bash
cp .env.example .env.d/9router.env
```

Example:

```bash
PORT=20128
API_BASE_URL=https://api.example.com
JWT_SECRET=your-secret
NODE_ENV=production
```

## 2. Safe production startup

Use:

```bash
bash scripts/run-production.sh 9router 20128
```

This loads `.env.d/9router.env`, runs the app in the background, stores the PID, and writes logs to `.runtime/logs/`.

## 3. Reverse proxy and TLS

For public-facing services, place a reverse proxy in front of the app, for example:
- Caddy
- NGINX
- Traefik

Use HTTPS termination and restrict direct app access.

## 4. Secrets handling

Never store secrets in Git.
Keep them in:
- `.env.d/*.env`
- system environment variables
- a secret manager, if available

Add `.env.d` to `.gitignore` and commit only templates.

## 5. Monitoring and automatic restarts

For a production host, use:
- systemd unit files
- supervisor
- PM2
- docker compose

For Termux, keep it lightweight and rely on `winrx health` and manual restarts unless you specifically need service persistence.

## 6. Recommended hardening checklist

- HTTPS enabled
- strong auth or IP allowlists
- logs centralized
- `.env` not committed
- app startup command explicit
- health checks enabled
- timeouts and retries configured
- service restart policy defined
