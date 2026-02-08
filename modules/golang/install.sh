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

# Detect existing go (if any)
OLD_GO="$(command -v go || true)"

if [ -n "$OLD_GO" ]; then
  OLD_GO_ROOT="$(cd "$(dirname "$OLD_GO")/.." && pwd)"

  case "$OLD_GO_ROOT" in
    /usr/local/go|/usr/lib/go|/opt/go)
      echo "▶ Removing old Go at $OLD_GO_ROOT"
      sudo rm -rf "$OLD_GO_ROOT"
      ;;
    *)
      echo "▶ Existing Go found at $OLD_GO (not removing)"
      ;;
  esac
else
  echo "▶ No existing Go found"
fi

echo "▶ Extracting Go to /usr/local"
sudo tar -C /usr/local -xzf "$TMP"

echo "▶ Cleaning up tarball"
rm -f "$TMP"

# Re-resolve go (new install should be first on PATH)
GO_BIN="$(command -v go)"

echo "▶ Using Go at $GO_BIN"

# Install gopls using the resolved go
echo "▶ Installing gopls"
sudo env \
  GOBIN=/usr/local/bin \
  "$GO_BIN" install golang.org/x/tools/gopls@latest

echo "✔ Go ${VERSION} and gopls installed successfully"

