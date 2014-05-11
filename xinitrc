#!/bin/sh

# Append & to everything ?

# Load fonts
xset +fp /usr/share/fonts/local,/usr/share/fonts/OTF
xset fp rehash

# Remove beep
xset b off

xrdb -load ~/.Xresources

# Set background
WALLPAPER_FOLDER=~/.wallpaper
WALLPAPER=HumbleBundleFive.png
feh --bg-max --no-fehbg $WALLPAPER_FOLDER/$WALLPAPER &

# Launch urxvt daemon (so other instances are launched quickly)
# Unless this is already configured elsewhere (with systemctl), uncomment this.
urxvtd -q -o -f &


# System Tray - CHANGE BACK TO TOP
TINT='#002b36'
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 100 --transparent true --alpha 0 --tint $TINT --height 16 &

# Power Manager
xfce4-power-manager &

# Network Manager
nm-applet &

# Volume Manager
volti &

# Dropbox
dropboxd &

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

# Launch instance of terminal
#urxvtc &

# Load bspwm
exec bspwm -s "$PANEL_FIFO" -p W
