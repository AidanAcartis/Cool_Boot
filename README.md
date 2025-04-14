# Live Wallpaper Setup on Ubuntu 24.04 LTS

This project sets up an **animated live wallpaper** on Ubuntu 24.04 LTS using `xwinwrap` and `mpv`, automatically launching at startup.

---

## Requirements

First, install the necessary dependencies:

```bash
sudo apt-get install xorg-dev build-essential libx11-dev x11proto-xext-dev libxrender-dev libxext-dev
```

Then, install **xwinwrap**:

```bash
git clone https://github.com/mmhobi7/xwinwrap.git
cd xwinwrap
make
sudo make install
make clean
```

`xwinwrap` is a tool that allows you to stick a video player window to your desktop background.

You also need `mpv` to play videos:

```bash
sudo apt install mpv
```


## Script to Launch Live Wallpaper

Create a script, e.g., `the_script.sh`, with the following content:

```bash
#!/bin/bash

export DISPLAY=:0

# Kill xwinwrap if already running
if pgrep xwinwrap > /dev/null; then
  killall xwinwrap
fi

# Change to the script's directory
cd /home/aidan/Documents/wallpap/Live_wallpaps

# Launch animated wallpaper
xwinwrap -g 1920x1080+0+0 -ni -s -st -sp -b -nf -- \
mpv --loop=inf --no-audio --vo=gpu --profile=low-latency \
--no-border --force-window=yes --geometry=1920x1080 \
--no-osc --no-input-default-bindings --no-config MPV/anata.mp4
```

✅ Make sure the script is executable:

```bash
chmod +x /home/aidan/Documents/wallpap/Live_wallpaps/the_script.sh
```


## Auto-Start at Login

Create a `.desktop` file inside `~/.config/autostart/`.

Example: `live_wallpaper.desktop`

```ini
[Desktop Entry]
Type=Application
Exec=bash -c "until xwininfo -root >/dev/null 2>&1; do sleep 1; done; sleep 2; /home/aidan/Documents/wallpap/Live_wallpaps/the_script.sh"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Live Wallpaper
Comment=Fond animé selon le jour
```

This makes sure the script starts **only after the desktop environment is fully ready**.


## Stopping the Live Wallpaper

If you want to stop the wallpaper manually, run:

```bash
killall xwinwrap
```

This will terminate the `xwinwrap` process and stop the video.


## Playing a Sound After Boot

If you want to play a sound file like `Luffylaugh.wav` after login:

Add this to your startup script **after** launching the wallpaper:

```bash
aplay /home/aidan/Documents/wallpap/Live_wallpaps/Luffylaugh.wav
```

Or add a second `.desktop` file for it:

```ini
[Desktop Entry]
Type=Application
Exec=aplay /home/aidan/Documents/wallpap/Live_wallpaps/Luffylaugh.wav
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Play Sound
Comment=Play Luffy Laugh Sound at startup
```


## Notes

- Ensure your video (`anata.mp4`) exists exactly at `/home/aidan/Documents/wallpap/Live_wallpaps/MPV/anata.mp4`.
- If you move your project, update the paths in both the script and `.desktop` file.
- If you use multiple monitors, you may need to adjust the geometry (e.g., `3840x1080`).

Enjoy your animated desktop! 🌟

