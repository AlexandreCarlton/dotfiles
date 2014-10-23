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
xset +fp /usr/share/fonts/local,/usr/share/fonts/OTF
xset fp rehash

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

# Launch urxvt daemon (so other instances are launched quickly)
# Unless already configured with systemd
# What if it fails? systemctl --failed lists all failed,
# should probably check that too.
if [[ $(systemctl | grep --count "urxvtd@${USER}\.service") -eq 0 ]]; then
    urxvtd -q -o -f &
fi

. ~/.profile


# System Tray - CHANGE BACK TO TOP
#TINT='0x002b36'
#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 100 --transparent true --alpha 0 --tint $TINT --height 16 &

# Thunar (File manager)
#thunar --daemon &

# Power Manager
#xfce4-power-manager &

# Network Manager
nm-applet &

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


# Managers like GDM ignore this completely, so we execute it somewhere where it is BOUND to be called
# (like zshrc), checking to see if it had already been invoked.
#export XINITRC_LOADED=true

#~/.config/lxsession/LXDE/desktop.conf already does this for us.
#exec xmonad

# Load keybindings for bspwm
sxhkd &

# Load bspwm
exec bspwm -s "$PANEL_FIFO" -p W
#exec gnome-session
