#!/bin/bash

export DISPLAY=:0

# Aller dans le répertoire contenant le fichier vidéo
cd /home/aidan/Documents/wallpap/Live_wallpaps || exit 1

# Stoppe seulement s'il existe
if pgrep xwinwrap > /dev/null; then
  killall xwinwrap
fi

# Lance le fond animé EN ARRIÈRE-PLAN, NON INTERACTIF
xwinwrap -g 1920x1080+0+0 -ni -s -st -sp -b -nf -- \
mpv --loop=inf --no-audio --vo=gpu --profile=low-latency \
--no-border --force-window=yes --geometry=1920x1080 \
--no-osc --no-input-default-bindings --no-config ./MPV/anata.mp4
