#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Resolve target user + home (works with or without sudo)
if [ -n "${SUDO_USER:-}" ]; then
  TARGET_USER="$SUDO_USER"
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  TARGET_USER="$(whoami)"
  USER_HOME="$HOME"
fi

CARGO_HOME="${CARGO_HOME:-$USER_HOME/.cargo}"
CARGO_BIN="$CARGO_HOME/bin"

export CARGO_HOME
export PATH="$CARGO_BIN:$PATH"

echo "▶ Installing starship for user: $TARGET_USER"

# Ensure rustup
if [ ! -x "$CARGO_BIN/rustup" ]; then
  echo "▶ installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sudo -u "$TARGET_USER" sh -s -- -y
fi

# Ensure cargo-binstall
if [ ! -x "$CARGO_BIN/cargo-binstall" ]; then
  echo "▶ installing cargo-binstall"
  curl -L --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
    | sudo -u "$TARGET_USER" bash
fi

# Install starship
if [ ! -x "$CARGO_BIN/starship" ]; then
  echo "▶ installing starship (cargo binstall)"
  sudo -u "$TARGET_USER" "$CARGO_BIN/cargo" binstall -y starship
else
  echo "▶ starship already installed"
fi

# Install config
CONFIG_SRC="$MODULE_DIR/starship.toml"
CONFIG_DST="$USER_HOME/.config/starship.toml"
BACKUP_DST="$CONFIG_DST.bak"

echo "▶ installing starship config"
mkdir -p "$USER_HOME/.config"

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  echo "  backing up existing config → starship.toml.bak"
  mv "$CONFIG_DST" "$BACKUP_DST"
fi

ln -s "$CONFIG_SRC" "$CONFIG_DST"

# Fix ownership if run under sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown "$TARGET_USER:$TARGET_USER" "$CONFIG_DST"
fi

echo "✔ starship installed"

