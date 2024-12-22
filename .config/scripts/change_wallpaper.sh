#!/bin/bash

dir_night="/home/$USER/.config/backgrounds/night/"
dir_day="/home/$USER/.config/backgrounds/day/"

night_hour=18
morning_hour=6

random_image() {
  local dir="$1"
  local images=($(ls "$dir"))
  local random_index=$(( RANDOM % ${#images[@]} ))
  echo "${images[$random_index]}"
}

# Verifica a hora atual
current_hour=$(date +%H)

# Define o diretório de acordo com a hora
if [ "$current_hour" -ge "$night_hour" ] && [ "$current_hour" -lt "$morning_hour" ]; then
  theme="dark"
  dir="$dir_night"
else
  theme="light"
  dir="$dir_day"
fi

# Seleciona uma imagem aleatória do diretório
image=$(random_image "$dir")

# Caminho completo da imagem
image_path="$dir$image"

# Executa o comando para alterar o wallpaper (ajuste de acordo com sua configuração)
matugen image "$image_path"
