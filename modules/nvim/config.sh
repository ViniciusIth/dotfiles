#!/usr/bin/env bash
set -euo pipefail

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_SRC="$MODULE_DIR/config"
CONFIG_DST="$HOME/.config/nvim"
BACKUP_DST="$HOME/.config/nvim.bak"

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing config → $BACKUP_DST"
  rm -rf "$BACKUP_DST"
  mv "$CONFIG_DST" "$BACKUP_DST"
fi

mkdir -p "$HOME/.config"
ln -s "$CONFIG_SRC" "$CONFIG_DST"

if [ -n "${SUDO_USER:-}" ]; then
  chown -h "$TARGET_USER:$TARGET_USER" "$CONFIG_DST"
fi

echo "✔ neovim configured"

