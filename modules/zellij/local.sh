#!/usr/bin/env sh
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo is required but was not found in PATH"
  exit 1
fi

echo "=> Installing zellij..."

if ! command -v zellij >/dev/null 2>&1; then
  cargo binstall -y zellij
else
  echo "=> zellij already installed"
fi

echo "✔ zellij installed:"
zellij --version

