#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -n "${SUDO_USER:-}" ]; then
  TARGET_USER="$SUDO_USER"
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  TARGET_USER="$(whoami)"
  USER_HOME="$HOME"
fi

BIN_DIR="$USER_HOME/.local/bin"
NVIM_DIR="$USER_HOME/.local/nvim"

echo "▶ Installing neovim (managerless)"

if command -v nvim >/dev/null 2>&1; then
  echo "  neovim already installed"
else
  mkdir -p "$BIN_DIR"

  CHANNEL="nightly"
  ARCH="linux-x86_64"

  URL="https://github.com/neovim/neovim/releases/download/${CHANNEL}/nvim-${ARCH}.tar.gz"

  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT

  echo "  downloading neovim (${CHANNEL})"
  curl -fsSL "$URL" -o "$TMP/nvim.tar.gz"

  echo "  extracting"
  tar -xzf "$TMP/nvim.tar.gz" -C "$TMP"

  rm -rf "$NVIM_DIR"
  mv "$TMP/nvim-${ARCH}" "$NVIM_DIR"

  ln -sf "$NVIM_DIR/bin/nvim" "$BIN_DIR/nvim"

  if [ -n "${SUDO_USER:-}" ]; then
    chown -R "$TARGET_USER:$TARGET_USER" "$NVIM_DIR" "$BIN_DIR/nvim"
  fi
fi

insta

CONFIG_SRC="$MODULE_DIR/config"
CONFIG_DST="$USER_HOME/.config/nvim"
BACKUP_DST="$USER_HOME/.config/nvim.bak"

echo "▶ Installing dependencies"
sudo pacman -S --noconfirm tree-sitter-cli

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing nvim config → nvim.bak"
  rm -rf "$BACKUP_DST"
  mv "$CONFIG_DST" "$BACKUP_DST"
fi

mkdir -p "$USER_HOME/.config"
ln -s "$CONFIG_SRC" "$CONFIG_DST"

if [ -n "${SUDO_USER:-}" ]; then
  chown -h "$TARGET_USER:$TARGET_USER" "$CONFIG_DST"
fi

echo "✔ neovim installed"


