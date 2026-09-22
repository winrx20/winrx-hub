# WinRX Hub

A professional control hub for all WinRX projects. This repository keeps each project independent while giving you one simple command layer to manage them from Termux.

## Goals
- Keep each app/repo modular and independent
- Provide one entry point for commands
- Make the ecosystem easy to manage from Termux
- Standardize install, start, stop, and update flows

## Quick start

```bash
git clone https://github.com/winrx20/winrx-hub.git
cd winrx-hub
bash install.sh
export PATH="$PWD/bin:$PATH"
winrx status
```

## Main commands

```bash
winrx status
winrx list
winrx start 9router
winrx stop 9router
winrx update
winrx doctor
```

## Project structure

```text
winrx-hub/
  README.md
  install.sh
  .env.example
  registry.json
  .gitignore
  bin/
    winrx
  apps/
    README.md
    9router/
    SeeStack/
    gum/
    FckSignups/
    docs/
    mastermind/
    termux-tools/
    termux-packages/
  scripts/
    start.sh
    stop.sh
    update.sh
    status.sh
```

## Recommended architecture

This is not a monorepo in the destructive sense. Instead, it is an orchestration layer:
- each repo stays independent
- the hub keeps a registry of apps
- the CLI provides common commands for Termux
- management is centralized without forcing code sharing

## Termux setup

```bash
pkg update
pkg install git curl wget python nodejs npm golang

git clone https://github.com/winrx20/winrx-hub.git
cd winrx-hub
bash install.sh
export PATH="$PWD/bin:$PATH"
winrx status
```

## Notes

- Use `bash bin/winrx ...` if your shell does not have the script executable bit set.
- Add repo folders under `apps/` as you continue development.
- Update `registry.json` when you add or remove apps.

## License

MIT
