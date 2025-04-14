#!/bin/bash

export DISPLAY=:0

sleep 1

# Aller dans le répertoire contenant le fichier vidéo
cd /home/aidan/Documents/wallpap/Live_wallpaps || exit 1

  # Joue le son (en arrière-plan aussi)
paplay /home/aidan/Documents/wallpap/Live_wallpaps/Luffylaugh.wav &

# Stoppe seulement xwinwrap s'il existe
if pgrep xwinwrap > /dev/null; then
  killall xwinwrap
fi

# Détermine quel jour on est
day=$(date +%u)  # 1 = lundi, 2 = mardi, ..., 7 = dimanche

# Associe chaque jour à une vidéo
case $day in
  1) video="./MPV/kami.mp4" ;;            # Lundi
  2) video="./MPV/Nika.mp4" ;;             # Mardi
  3) video="./MPV/Jinx.mp4" ;;             # Mercredi
  4) video="./MPV/anata.mp4" ;;            # Jeudi
  5) video="./MPV/shiro.mp4" ;;            # Vendredi
  6) video="./MPV/death-note-anime.mp4" ;; # Samedi
  7) video="./MPV/mimi.mp4" ;;             # Dimanche
  *) video="./MPV/anata.mp4" ;;            # Default (par sécurité)
esac

# Lancer le fond animé EN ARRIÈRE-PLAN NON INTERACTIF
# while true; do
  xwinwrap -g 1920x1080+0+0 -ni -s -st -sp -b -nf -- \
  mpv --loop=inf --no-audio --vo=gpu --profile=low-latency \
  --no-border --force-window=yes --geometry=1920x1080 \
  --no-osc --no-input-default-bindings --no-config "$video"


  # Si mpv crash ou s'arrête, il redémarre automatiquement
  # sleep 1
# done
