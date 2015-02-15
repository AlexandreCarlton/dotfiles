#!/bin/sh

# Remember to append & to things that would otherwise hang;
# Unless it's crucial the thing is executed.

# "Auto-run" - get rid of it? lose too much control
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Load fonts
xset +fp /usr/share/fonts/local &
xset +fp /usr/share/fonts/OTF &
xset +fp ${HOME}/.fonts &
# fc-cache -vf
xset fp rehash &

# Remove beep
xset b off &

[ -r ${HOME}/.Xresources ] && xrdb -load ${HOME}/.Xresources &

# TODO source ~/bin/export_colours.sh,
# Start dunst specifying the colours and fonts
# - sourcing everything in xinitrc.d/ usually starts it for us.
# See if you can get a dmenu daemon running with these parameters as well.

# Set background
WALLPAPER_FOLDER=${HOME}/.wallpaper
WALLPAPER=PikachuEevee.png
feh --bg-fill --no-fehbg ${WALLPAPER_FOLDER}/${WALLPAPER} &

# Launch URxvt Daemon (urxvtc to connect)
[ $(pgrep -cx urxvtd) -eq 0 ] && urxvtd -q -o -f &

# TODO do this in systemd
pulseaudio --start &

# Dropbox daemon
dropboxd &

# Automount removable drives with udisks
udiskie &

# Set regular cursor
xsetroot -cursor_name left_ptr &

# Hide cursor when not in use (move to restore)
unclutter &

DEFAULT_ENVIRONMENT=bspwm
environment=${1:-${DEFAULT_ENVIRONMENT}}

case ${environment} in
    bspwm)
        sxhkd &
        exec bspwm -s "$PANEL_FIFO" -p W
        ;;
    xmonad)
        exec xmonad
        ;;
esac
