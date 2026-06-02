#!/usr/bin/env sh
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
GIT_DIR="$HOME/.local/git"

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
