#!/usr/bin/env sh
set -eu

if command -v rustup >/dev/null 2>&1; then
  echo "▶ rustup already installed"
else
  echo "▶ installing rustup"
  curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y
fi

# Load rustup env for this script run
export PATH="$HOME/.cargo/bin:$PATH"

echo "▶ installing stable toolchain"
rustup toolchain install stable

echo "▶ setting stable as default"
rustup default stable

echo "✔ Rust installed successfully"

