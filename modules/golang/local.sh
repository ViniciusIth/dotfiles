#!/usr/bin/env sh
set -eu

LOCAL_DIR="$HOME/.local"
BIN_DIR="$LOCAL_DIR/bin"
TMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TMP_DIR"' EXIT

ARCH="$(uname -m)"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

VERSION="$(curl -fsSL https://go.dev/VERSION?m=text | sed -n '1p')"
TARBALL="${VERSION}.${OS}-${ARCH}.tar.gz"
URL="https://go.dev/dl/${TARBALL}"

echo "=> Installing Go ${VERSION} to $LOCAL_DIR..."

mkdir -p "$BIN_DIR"

curl -fsSL "$URL" | tar -xz -C "$TMP_DIR"

rm -rf "$LOCAL_DIR/go"
cp -R "$TMP_DIR/go" "$LOCAL_DIR/go"

ln -sf "$LOCAL_DIR/go/bin/go" "$BIN_DIR/go"
ln -sf "$LOCAL_DIR/go/bin/gofmt" "$BIN_DIR/gofmt"

echo "=> Installing gopls..."
GOBIN="$BIN_DIR" "$BIN_DIR/go" install golang.org/x/tools/gopls@latest

echo "✅ Go installed:"
"$BIN_DIR/go" version

echo "✅ gopls installed:"
"$BIN_DIR/gopls" version
