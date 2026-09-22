# WinRX deployment

## Termux auto-start

Install the Termux:Boot Android add-on, then run:

```bash
bash scripts/install-termux-boot.sh
```

The boot script starts only applications in `registry.json` with both:

```json
{"enabled": true, "autoStart": true}
```

Do not enable development servers automatically unless you explicitly want them running after boot.

## Production mode

Mark a service with `production: true` and provide its real production command in `productionCommand` or `command`.
Then run:

```bash
bash scripts/production.sh
```

On a Linux host with systemd:

```bash
bash scripts/production-install.sh
```

On Termux, use Termux:Boot rather than systemd. The hub does not expose services to the internet by itself; use a reverse proxy, firewall, HTTPS, authentication, and secrets stored outside Git.

## Useful checks

```bash
winrx health
winrx status
winrx logs 9router
winrx stop all
```
