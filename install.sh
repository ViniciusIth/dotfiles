#!/bin/bash

yay --save --norebuild --noredownload --answerclean None --answerdiff None

# Nerd Font
yay -S --needed ttf-jetbrains-mono

# Hyprland, login and essentials
yay -S --needed hyprland-git kitty sddm-git zsh wlogout swaync wofi man-db

# Nvim and tmux
yay -S --needed neovim-git wl-copy ripgrep tmux

# Print etc
yay -S --needed grim slurp

# Background
yay -S --needed swaybg waypaper

# Misc
yay -S --needed btop-git wallust
