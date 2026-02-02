#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Resolve target user + home
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

echo "▶ Installing zellij for user: $TARGET_USER"

# Ensure rustup
if [ ! -x "$CARGO_BIN/rustup" ]; then
  echo "▶ installing rustup (curl)"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sudo -u "$TARGET_USER" sh -s -- -y
else
  echo "▶ rustup already installed"
fi

# Ensure cargo-binstall
if [ ! -x "$CARGO_BIN/cargo-binstall" ]; then
  echo "▶ installing cargo-binstall"
  curl -L --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
    | sudo -u "$TARGET_USER" bash
else
  echo "▶ cargo-binstall already installed"
fi

# Install zellij
if [ ! -x "$CARGO_BIN/zellij" ]; then
  echo "▶ installing zellij (cargo binstall)"
  sudo -u "$TARGET_USER" "$CARGO_BIN/cargo" binstall -y zellij
else
  echo "▶ zellij already installed"
fi

# Install config
CONFIG_SRC="$MODULE_DIR/config.kdl"
CONFIG_DIR="$USER_HOME/.config/zellij"
CONFIG_DST="$CONFIG_DIR/config.kdl"
BACKUP_DST="$CONFIG_DIR/config.kdl.bak"

echo "▶ installing zellij config"
mkdir -p "$CONFIG_DIR"

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  if [ "$(readlink "$CONFIG_DST" 2>/dev/null || true)" != "$CONFIG_SRC" ]; then
    echo "  backing up existing config → config.kdl.bak"
    mv "$CONFIG_DST" "$BACKUP_DST"
  else
    echo "  config already linked"
    exit 0
  fi
fi

ln -s "$CONFIG_SRC" "$CONFIG_DST"

# Fix ownership if run under sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown -h "$TARGET_USER:$TARGET_USER" "$CONFIG_DST"
fi

echo "✔ zellij installed"

