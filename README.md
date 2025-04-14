# 🎥 Live Animated Wallpaper + Startup Sound on Ubuntu 24.04 LTS

Ce projet permet de :

- Lancer automatiquement un **fond d’écran animé** au démarrage.
- Jouer un **son** après que le démarrage est complètement terminé.

---

## 📋 Prérequis

- Ubuntu 24.04 LTS
- `xwinwrap` installé
- `mpv` installé
- `aplay` installé (pour jouer les fichiers `.wav`)
- (Optionnel) Git si tu veux tout versionner

Installe les outils nécessaires :

```bash
sudo apt update
sudo apt install xwinwrap mpv alsa-utils git
```

---

## 🛠️ Structure du projet

```bash
/home/aidan/Documents/wallpap/Live_wallpaps/
├── all_day.sh          # Script principal lancé au démarrage
├── the_script.sh       # Script qui lance le fond d’écran animé
├── MPV/
│   └— anata.mp4       # Vidéo du fond d’écran
├── GIF/                # (Optionnel) GIFs
└— Luffylaugh.wav      # Son joué au démarrage
```

---

## ⚙️ Scripts

### `the_script.sh`

Ce script :

- TUE tout ancien fond animé (`xwinwrap`).
- Démarre un nouveau fond animé en boucle.

```bash
#!/bin/bash

export DISPLAY=:0

# Aller dans le répertoire contenant le fichier vidéo
cd /home/aidan/Documents/wallpap/Live_wallpaps || exit 1

  # Joue le son (en arrière-plan aussi)
paplay /home/aidan/Documents/wallpap/Live_wallpaps/Luffylaugh.wav &

# Stoppe seulement s'il existe
if pgrep xwinwrap > /dev/null; then
  killall xwinwrap
fi

# Lance le fond animé EN ARRIÈRE-PLAN, NON INTERACTIF
xwinwrap -g 1920x1080+0+0 -ni -s -st -sp -b -nf -- \
mpv --loop=inf --no-audio --vo=gpu --profile=low-latency \
--no-border --force-window=yes --geometry=1920x1080 \
--no-osc --no-input-default-bindings --no-config ./MPV/anata.mp4

```

### `all_day.sh`

Ce script :

- Lance `the_script.sh`.
- Joue un son à la fin du démarrage.

```bash
#!/bin/bash

# Attendre que le serveur X soit prêt
until xwininfo -root >/dev/null 2>&1; do sleep 1; done
sleep 2

# Se placer dans le dossier du script
cd "$(dirname "$0")"

# Lancer le fond animé
bash ./the_script.sh &

# Jouer un son après
aplay Luffylaugh.wav
```

---

## 📅 Lancement automatique au démarrage

Créer un fichier `.desktop` :

```bash
nano ~/.config/autostart/live_wallpaper.desktop
```

Contenu :

```ini
[Desktop Entry]
Type=Application
Exec=bash -c "until xwininfo -root >/dev/null 2>&1; do sleep 1; done; sleep 2; /home/aidan/Documents/wallpap/Live_wallpaps/all_day.sh"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Live Wallpaper
Comment=Fond animé selon le jour
```

Assure-toi que ton fichier `.desktop` est exécutable :

```bash
chmod +x ~/.config/autostart/live_wallpaper.desktop
```

---

## 🔄 Arrêter le fond d’écran animé

Si tu veux arrêter le fond animé manuellement :

```bash
killall xwinwrap
```

---

## 💰 Bonus : GitHub

Pour initialiser un dépôt Git :

```bash
cd /home/aidan/Documents/wallpap/Live_wallpaps
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/ton-user/ton-repo.git
git push -u origin main
```

---

> Réalisé avec ❤️ par Aidan.

