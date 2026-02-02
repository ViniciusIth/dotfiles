#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -n "${SUDO_USER:-}" ]; then
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  USER_HOME="$HOME"
fi

echo "▶ Installing git config"

if ! command -v git >/dev/null 2>&1; then
    sudo dnf -y install git
fi

SRC="$MODULE_DIR/gitconfig"
DST="$USER_HOME/.gitconfig"
BACKUP="$USER_HOME/.gitconfig.bak"

if [ -e "$DST" ] || [ -L "$DST" ]; then
  if [ "$(readlink "$DST" 2>/dev/null || true)" != "$SRC" ]; then
    echo "  backing up existing .gitconfig → .gitconfig.bak"
    mv "$DST" "$BACKUP"
  else
    echo "  .gitconfig already linked"
    exit 0
  fi
fi

ln -s "$SRC" "$DST"

if [ -n "${SUDO_USER:-}" ]; then
  chown -h "$SUDO_USER:$SUDO_USER" "$DST"
fi

echo "✔ git configured"

