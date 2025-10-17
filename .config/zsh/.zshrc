## Zsh
# Allow for some cool tricks
setopt extended_glob
zstyle ':plugin:ez-compinit' 'compstyle' 'zshzoo'
# Zsh HISTORY
HISTFILE=~/.local/share/zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
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

if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

source $ZDOTDIR/.antidote/antidote.zsh
antidote load
compdef _git-switch git-swp

# Yazi wrapper
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function ls() {
  eza --icons --group-directories-first "$@"
}

function lo() {
  eza -l --icons --group-directories-first "$@"
}

lt() {
  local depth=2
  if [[ $# -gt 0 ]]; then
    depth=$1
    shift
  fi
  eza --tree --level=$depth --icons --group-directories-first "$@"
}

function lg() {
  eza -l --git --icons --group-directories-first "$@"
}

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ; myip
    # echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}

eval "$(zoxide init zsh)"
autoload -Uz promptinit && promptinit && prompt pure


export NVM_DIR="$HOME/.config/nvm"
export PATH="$PATH:$(go env GOPATH)/bin"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/viniciusith/.bun/_bun" ] && source "/home/viniciusith/.bun/_bun"
