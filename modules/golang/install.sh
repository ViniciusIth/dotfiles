#!/usr/bin/env sh
set -eu

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
TMP="/tmp/${TARBALL}"

echo "▶ Installing Go ${VERSION}"
echo "  downloading ${URL}"

curl -fLo "$TMP" "$URL"

echo "  removing old /usr/local/go"
sudo rm -rf /usr/local/go

echo "  extracting to /usr/local"
sudo tar -C /usr/local -xzf "$TMP"

echo "  cleaning up"
rm -f "$TMP"

echo "✔ Go ${VERSION} installed successfully"

