#!/bin/bash

yay --save --norebuild --noredownload --answerclean None --answerdiff None

# Nerd Font
yay -S --needed --noconfirm ttf-jetbrains-mono

# Hyprland, login and essentials
yay -S --needed --noconfirm hyprland-git kitty sddm-git zsh wlogout swaync wofi man-db

# Nvim and clipboard
yay -S --needed --noconfirm neovim-git wl-copy ripgrep clipse

# Print etc
yay -S --needed --noconfirm grim slurp

# Background
yay -S --needed --noconfirm swaybg waypaper

# Misc
yay -S --needed --noconfirm btop-git wallust
