#!/usr/bin/env sh
set -eu

# Absolute path to this module directory
MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Resolve target user home (important when run via sudo)
if [ -n "${SUDO_USER:-}" ]; then
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  USER_HOME="$HOME"
fi

echo "▶ Installing neovim (dnf)"

echo "  enabling COPR"
sudo dnf -y copr list | grep -q agriffis/neovim-nightly || \
  sudo dnf -y copr enable agriffis/neovim-nightly

echo "  installing packages"
sudo dnf -y install neovim python3-neovim

CONFIG_SRC="$MODULE_DIR/config"
CONFIG_DST="$USER_HOME/.config/nvim"
BACKUP_DST="$USER_HOME/.config/nvim.bak"

echo "  installing config"

# If ~/.config/nvim exists, back it up
if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing nvim config → nvim.bak"
  if [ -e "$BACKUP_DST" ] || [ -L "$BACKUP_DST" ]; then
      rm -rf "$BACKUP_DST"
  fi
  mv "$CONFIG_DST" "$BACKUP_DST"
fi

mkdir -p "$USER_HOME/.config"

ln -s "$CONFIG_SRC" "$CONFIG_DST"

# Fix ownership if run under sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown -R "$SUDO_USER:$SUDO_USER" "$CONFIG_DST"
fi

echo "✔ neovim installed"

