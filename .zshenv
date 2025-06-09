export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:~/.linuxbrew/bin
export PATH=$PATH:/usr/local/go/bin

. "$HOME/.cargo/env";

export ZDOTDIR="$HOME/.config/zsh";

# set xdg paths
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# use vim as the editor
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

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"
# Node
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Deno
export DENO_INSTALL="/home/viniciusith/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
