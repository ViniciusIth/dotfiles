#!/bin/bash

yay --save --norebuild --noredownload --answerclean None --answerdiff None

# Nerd Font
yay -S --needed --noconfirm ttf-jetbrains-mono

# Hyprland, login and essentials
yay -S --needed --noconfirm hyprland-git kitty sddm-git zsh wlogout wofi man-db bluez bluez-utils bluetui "gnome-bluetooth-3.0" ags

# Sound control etc
yay -S --needed --noconfirm pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pavucontrol brightnessctl

# Nvim and clipboard
yay -S --needed --noconfirm neovim-git wl-copy ripgrep clipse yazi

# Print etc
yay -S --needed --noconfirm grim slurp

# Background
yay -S --needed --noconfirm swaybg waypaper swww

# Misc
yay -S --needed --noconfirm btop-git wallust fastfetch
