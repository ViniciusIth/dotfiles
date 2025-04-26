# use keychain to not need to reenter ssh-add
eval `keychain --eval --agents ssh git_ed25519`

# Allow for some cool tricks
setopt extended_glob

export XDG_CONFIG_HOME="$HOME/.config"

# Default editor
export EDITOR=nvim

# System level paths
export PATH=$PATH:~/.local/share/lsp/bin
export PATH=$PATH:~/.local/scripts
export PATH=$PATH:~/go/bin
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:~/.cargo/bin

# JDK
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/bin
export PATH=$PATH:$JAVA_HOME/bin

# # Zsh-Autosuggestion
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# Node
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export DENO_INSTALL="/home/viniciusith/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Yazi wrapper
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Run fastfetch
fastfetch

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
