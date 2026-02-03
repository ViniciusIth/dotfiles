#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -n "${SUDO_USER:-}" ]; then
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  USER_HOME="$HOME"
fi

if ! command -v dms >/dev/null 2>&1; then
  echo "▶ Installing niri"
  sudo dnf -y copr enable avengemedia/dms
  sudo dnf -y install niri dms
  systemctl --user add-wants niri.service dms
fi

CONFIG_SRC="$MODULE_DIR/config"
CONFIG_DST="$USER_HOME/.config/niri"
BACKUP_DST="$USER_HOME/.config/niri.bak"

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing niri config → nvim.bak"
  if [ -e "$BACKUP_DST" ] || [ -L "$BACKUP_DST" ]; then
      rm -rf "$BACKUP_DST"
  fi
  mv "$CONFIG_DST" "$BACKUP_DST"
fi


ln -s "$CONFIG_SRC" "$CONFIG_DST"

if [ ! -x "$CARGO_BIN/cargo-binstall" ]; then

echo "✔ niri configured"
