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

CONFIG_SRC="$MODULE_DIR/opencode"
CONFIG_DST="$USER_HOME/.config/opencode"
BACKUP_DST="$USER_HOME/.config/opencode.bak"

run_as_target() {
  if [ -n "${SUDO_USER:-}" ]; then
    sudo -H -u "$TARGET_USER" sh -lc "$1"
  else
    sh -lc "$1"
  fi
}

target_has_cmd() {
  run_as_target "PATH=\"\$HOME/.local/bin:\$HOME/.npm/bin:\$HOME/.bun/bin:\$PATH\"; command -v $1 >/dev/null 2>&1"
}

echo "▶ Installing opencode for user: $TARGET_USER"

echo "▶ ensuring opencode CLI"
if target_has_cmd opencode; then
  echo "  opencode already installed"
else
  echo "  installing opencode CLI"
  run_as_target "tmp=\$(mktemp) && curl -fsSL https://opencode.ai/install -o \"\$tmp\" && bash \"\$tmp\" && rm -f \"\$tmp\""
fi

echo "▶ ensuring beads CLI (bd)"
if target_has_cmd bd; then
  echo "  bd already installed"
else
  echo "  installing beads CLI (bd)"
  run_as_target "curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash"
fi

echo "▶ installing opencode config"

mkdir -p "$USER_HOME/.config"

LINK_CONFIG=1

if [ -e "$CONFIG_DST" ] || [ -L "$CONFIG_DST" ]; then
  if [ "$(readlink "$CONFIG_DST" 2>/dev/null || true)" != "$CONFIG_SRC" ]; then
    echo "  backing up existing config → opencode.bak"
    mv "$CONFIG_DST" "$BACKUP_DST"
  else
    echo "  config already linked"
    LINK_CONFIG=0
  fi
fi

if [ "$LINK_CONFIG" -eq 1 ]; then
  ln -s "$CONFIG_SRC" "$CONFIG_DST"
fi

# Fix ownership if run under sudo
if [ -n "${SUDO_USER:-}" ] && [ -L "$CONFIG_DST" ]; then
  chown -h "$TARGET_USER:$TARGET_USER" "$CONFIG_DST"
fi

echo "✔ opencode installed"
