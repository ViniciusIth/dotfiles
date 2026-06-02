#!/usr/bin/env sh
set -euo pipefail

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_SRC="$MODULE_DIR/config/git"
CONFIG_DST="$HOME/.gitconfig"
BACKUP_DST="$HOME/.gitconfig.bak"
SSH_DIR="$HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing config → $BACKUP_DST"
  rm -rf "$BACKUP_DST"
  mv "$CONFIG_DST" "$BACKUP_DST"
fi

mkdir -p "$HOME/.config"
ln -s "$CONFIG_SRC" "$CONFIG_DST"

echo "▶ Configuring SSH agent behavior"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

touch "$SSH_CONFIG"
chmod 600 "$SSH_CONFIG"

if ! grep -q "AddKeysToAgent yes" "$SSH_CONFIG"; then
  echo "  adding AddKeysToAgent to ssh config"
  printf "\nHost *\n  AddKeysToAgent yes\n" >> "$SSH_CONFIG"
else
  echo "  AddKeysToAgent already set"
fi

echo "✔ git configured"
