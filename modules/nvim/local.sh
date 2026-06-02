#!/usr/bin/env bash
set -euo pipefail

LOCAL_DIR="$HOME/.local"
BIN_DIR="$LOCAL_DIR/bin"
TMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TMP_DIR"' EXIT

URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"

echo "=> Installing Neovim to $LOCAL_DIR..."

install -d "$BIN_DIR"

curl -fsSL "$URL" | tar -xz -C "$TMP_DIR"

cp -R "$TMP_DIR/nvim-linux-x86_64/." "$LOCAL_DIR/"

echo "▶ Installing dependencies"
sudo dnf install -y tree-sitter-cli

echo "✔ Neovim installed:"
"$BIN_DIR/nvim" --version | head -n 2
