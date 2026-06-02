#!/usr/bin/env sh
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo is required but was not found in PATH"
  exit 1
fi

echo "=> Installing yazi..."

if ! command -v yazi >/dev/null 2>&1; then
  cargo binstall -y yazi-fm
else
  echo "=> yazi already installed"
fi


echo "✔ Yazi installed:"
yazi --version
