# use keychain to not need to reenter ssh-add
eval `keychain --eval --agents ssh git_ed25519`



## Zsh
# Allow for some cool tricks
setopt extended_glob
# # The following lines were added by compinstall
zstyle :compinstall filename '/home/viniciusith/.zshrc'

autoload -Uz compinit
compinit
# # End of lines added by compinstall
export XDG_CONFIG_HOME="$HOME/.config"
# Default editor
export EDITOR=nvim
# Zsh-Autosuggestion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Zsh HISTORY
HISTFILE=~/.local/share/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

# System level paths
export PATH=$PATH:~/.local/share/lsp/bin
export PATH=$PATH:~/.local/scripts
export PATH=$PATH:~/go/bin
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:~/.cargo/bin

# JDK
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/bin
export PATH=$PATH:$JAVA_HOME/bin


# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# Node
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export DENO_INSTALL="/home/viniciusith/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if [ "$TMUX" = "" ]; then tmux; fi

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

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
