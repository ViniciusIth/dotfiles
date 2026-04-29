#!/usr/bin/env sh
set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -n "${SUDO_USER:-}" ]; then
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  USER_HOME="$HOME"
fi

BIN_DIR="$USER_HOME/.local/bin"
GIT_DIR="$USER_HOME/.local/git"

echo "▶ Installing git (portable binary)"

if command -v git >/dev/null 2>&1; then
  echo "  git already installed"
else
  mkdir -p "$BIN_DIR"

  VERSION="2.44.0"
  ARCH="x86_64"
  URL="https://github.com/git/git/releases/download/v${VERSION}/git-${VERSION}-linux-${ARCH}.tar.xz"

  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT

  echo "  downloading git ${VERSION}"
  curl -fsSL "$URL" -o "$TMP/git.tar.xz"

  echo "  extracting"
  tar -xJf "$TMP/git.tar.xz" -C "$TMP"

  rm -rf "$GIT_DIR"
  mv "$TMP/git-${VERSION}" "$GIT_DIR"

  ln -sf "$GIT_DIR/bin/git" "$BIN_DIR/git"

  echo "  git installed to $GIT_DIR"
fi

# config linking 

SRC="$MODULE_DIR/gitconfig"
DST="$USER_HOME/.gitconfig"
BACKUP="$USER_HOME/.gitconfig.bak"

if [ -e "$DST" ] || [ -L "$DST" ]; then
  if [ "$(readlink "$DST" 2>/dev/null || true)" != "$SRC" ]; then
    echo "  backing up existing .gitconfig → .gitconfig.bak"
    mv "$DST" "$BACKUP"
  else
    echo "  .gitconfig already linked"
    exit 0
  fi
fi

ln -s "$SRC" "$DST"

if [ -n "${SUDO_USER:-}" ]; then
  chown -h "$SUDO_USER:$SUDO_USER" "$DST"
fi

echo "✔ git configured"

SSH_DIR="$USER_HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"

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

if [ -n "${SUDO_USER:-}" ]; then
  chown -R "$SUDO_USER:$SUDO_USER" "$SSH_DIR"
fi

echo "✔ ssh configured"
