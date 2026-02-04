#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ -n "${SUDO_USER:-}" ]; then
  TARGET_USER="$SUDO_USER"
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  TARGET_USER="$(whoami)"
  USER_HOME="$HOME"
fi

echo "▶ Installing niri + DMS"

if ! command -v dms >/dev/null 2>&1; then
  sudo dnf -y copr enable avengemedia/dms
  sudo dnf -y install niri dms
fi

if command -v systemctl >/dev/null 2>&1; then
  sudo -u "$TARGET_USER" systemctl --user add-wants niri.service dms || true
fi

mkdir -p "$USER_HOME/.config"

link_config() {
  NAME="$1"
  SRC="$2"
  DST="$USER_HOME/.config/$NAME"
  BAK="$DST.bak"

  echo "▶ configuring $NAME"

  if [ -e "$DST" ] || [ -L "$DST" ]; then
    if [ -L "$DST" ] && [ "$(readlink "$DST")" = "$SRC" ]; then
      echo "  $NAME already linked"
      return
    fi

    echo "  backing up existing $NAME config → $NAME.bak"
    mv "$DST" "$BAK"
  fi

  ln -s "$SRC" "$DST"

  if [ -n "${SUDO_USER:-}" ]; then
    chown -h "$TARGET_USER:$TARGET_USER" "$DST"
  fi
}

link_config "niri" "$MODULE_DIR/niri/config"
link_config "DankMaterialShell" "$MODULE_DIR/DankMaterialShell/config"

echo "✔ niri + DMS configured"

