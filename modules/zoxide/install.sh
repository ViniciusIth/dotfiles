set -eu

MODULE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Resolve target user + home
if [ -n "${SUDO_USER:-}" ]; then
  TARGET_USER="$SUDO_USER"
  USER_HOME="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
else
  TARGET_USER="$(whoami)"
  USER_HOME="$HOME"
fi

CARGO_HOME="${CARGO_HOME:-$USER_HOME/.cargo}"
CARGO_BIN="$CARGO_HOME/bin"

export CARGO_HOME
export PATH="$CARGO_BIN:$PATH"

echo "▶ Installing zoxide for user: $TARGET_USER"

# Ensure rustup
if [ ! -x "$CARGO_BIN/rustup" ]; then
  echo "▶ installing rustup (curl)"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sudo -u "$TARGET_USER" sh -s -- -y
else
  echo "▶ rustup already installed"
fi

# Ensure cargo-binstall
if [ ! -x "$CARGO_BIN/cargo-binstall" ]; then
  echo "▶ installing cargo-binstall"
  curl -L --proto '=https' --tlsv1.2 -sSf \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
    | sudo -u "$TARGET_USER" bash
else
  echo "▶ cargo-binstall already installed"
fi

if [ ! -x "$CARGO_BIN/zoxide" ]; then
  echo "▶ installing zoxide (cargo binstall)"
  sudo -u "$TARGET_USER" "$CARGO_BIN/cargo" binstall -y zoxide
else
  echo "▶ zoxide already installed"
fi

echo "✔  zoxide installed"
