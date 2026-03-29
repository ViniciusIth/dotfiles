#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_SRC="$MODULE_DIR/default.conf"
CONFIG_DST="/etc/keyd/default.conf"
BACKUP_DST="/etc/keyd/default.conf.bak"

echo "▶ Installing keyd"

if ! pacman -Q keyd >/dev/null 2>&1; then
  sudo pacman -S --noconfirm keyd
else
  echo "  keyd already installed"
fi


sudo mkdir -p /etc/keyd

if [ ! -f "$CONFIG_SRC" ]; then
  echo "✖ keyd config missing: $CONFIG_SRC"
  exit 1
fi

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing keyd config → default.conf.bak"
  sudo rm -f "$BACKUP_DST"
  sudo mv "$CONFIG_DST" "$BACKUP_DST"
fi

echo "▶ Deploying keyd config"

echo "  using copying → /etc/keyd/default.conf"
sudo ln -s "$CONFIG_SRC" "$CONFIG_DST"

sudo chown root:root "$CONFIG_DST"
sudo chmod 644 "$CONFIG_DST"

sudo systemctl enable --now keyd

echo "✔ keyd installed and configured"

