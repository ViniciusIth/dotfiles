#!/usr/bin/env sh
set -eu

# Detect existing Go (if any)
OLD_GO="$(command -v go || true)"

if [ -n "$OLD_GO" ]; then
  echo "▶ Existing Go found at $OLD_GO"
  echo "  current version: $(go version)"
else
  echo "▶ No existing Go found"
fi

echo "▶ Updating package databases"
sudo pacman -Sy --noconfirm

echo "▶ Installing/updating golang"
sudo pacman -S --noconfirm go

GO_BIN="$(command -v go)"

echo "▶ Using Go at $GO_BIN"
echo "  version: $(go version)"

echo "▶ Installing/updating gopls"
sudo env \
  GOBIN=/usr/local/bin \
  "$GO_BIN" install golang.org/x/tools/gopls@latest

echo "✔ Go $(go version) and gopls installed successfully"
