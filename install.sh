#!/bin/bash

yay --save --norebuild --noredownload --answerclean None --answerdiff None

yay -Syu --needed - < /home/viniciusith/Documents/dotfiles/pkglist.txt
