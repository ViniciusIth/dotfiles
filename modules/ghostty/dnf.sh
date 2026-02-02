#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Resolve target user + home
if [ -n "${SUDO_USER:-}" ]; then
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  USER_HOME="$HOME"
fi

echo "▶ Installing ghostty (dnf)"

echo "  enabling COPR"
sudo dnf -y copr list | grep -q scottames/ghostty || \
  sudo dnf -y copr enable scottames/ghostty

echo "  installing package"
sudo dnf -y install ghostty

CONFIG_SRC="$MODULE_DIR/config"
CONFIG_DIR="$USER_HOME/.config/ghostty"
CONFIG_DST="$CONFIG_DIR/config"
BACKUP_DST="$CONFIG_DIR/config.bak"

echo "  linking config for user: ${SUDO_USER:-$(whoami)}"

# If ~/.config/ghostty exists as a FILE, back it up
if [ -f "$CONFIG_DIR" ]; then
  echo "  backing up file ~/.config/ghostty → ghostty.bak"
  mv "$CONFIG_DIR" "$CONFIG_DIR.bak"
fi

mkdir -p "$CONFIG_DIR"

# If config exists and is not our symlink, back it up
if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  if [ "$(readlink "$CONFIG_DST" 2>/dev/null || true)" != "$CONFIG_SRC" ]; then
    echo "  backing up existing config to config.bak"
    mv "$CONFIG_DST" "$BACKUP_DST"
  else
    echo "  config already linked"
    exit 0
  fi
fi

ln -s "$CONFIG_SRC" "$CONFIG_DST"

# Fix ownership if running under sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown -h "$SUDO_USER:$SUDO_USER" "$CONFIG_DST"
fi

echo "✔ ghostty installed"

