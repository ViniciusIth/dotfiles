# modules/bash/shell.bash
# Core bash defaults

# History
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND='history -a'

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
