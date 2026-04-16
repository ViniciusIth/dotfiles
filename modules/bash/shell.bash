# modules/bash/shell.bash
# Core bash defaults

# History
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Safer defaults
set -o noclobber
set -o notify

# Completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Editor
export EDITOR=vim
export VISUAL=vim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
