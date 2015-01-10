#!/bin/sh

# Append & to everything ?

# "Auto-run" - get rid of it, lose too much control
if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        if [[ -x "$f" ]]; then
            . "$f"
        fi
    done
fi

# Load fonts
xset +fp /usr/share/fonts/local,/usr/share/fonts/OTF,/home/alexandre/.fonts
# fc-cache -vf
xset fp rehash &

# Remove beep
xset b off

if [[ -f ~/.Xresources ]]; then
    xrdb -load ~/.Xresources
fi

# TODO source ~/bin/export_colours.sh,
# Start dunst specifying the colours and fonts
# - sourcing everything in xinitrc.d/ usually starts it for us.
# See if you can get a dmenu daemon running with these parameters as well.

# Set background
WALLPAPER_FOLDER=~/.wallpaper
WALLPAPER=PikachuEevee.png
feh --bg-fill --no-fehbg $WALLPAPER_FOLDER/$WALLPAPER &

if [[ -z $(pidof urxvtd) ]]; then
    urxvtd -q -o -f &
fi

. ~/.profile


# TODO do this in systemd
pulseaudio --start &

# System Tray - CHANGE BACK TO TOP
#TINT='0x002b36'
#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 100 --transparent true --alpha 0 --tint $TINT --height 16 &

# Thunar (File manager)
# thunar --daemon &

# Power Manager
#xfce4-power-manager &

# Network Manager
# nm-applet &

# Volume Manager
#volti &

# Dropbox daemon
dropboxd &

# Automount removable drives with udisks
udiskie &

# Set regular cursor
xsetroot -cursor_name left_ptr &

# Hide cursor when not in use (move to restore)
unclutter &

# Load keybindings for bspwm
sxhkd &

# Load bspwm
exec bspwm -s "$PANEL_FIFO" -p W
