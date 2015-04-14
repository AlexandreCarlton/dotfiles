#!/bin/sh

# This is used as a fall-back if systemd fails to launch Xorg.
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

# Don't fork this; pretty crucial.
[ -r ${HOME}/.Xresources ] && xrdb -load ${HOME}/.Xresources

# TODO source ~/bin/export_colours.sh,
# Start dunst specifying the colours and fonts
# - sourcing everything in xinitrc.d/ usually starts it for us.
# See if you can get a dmenu daemon running with these parameters as well.

# Set background
sh ${HOME}/.fehbg &

# Launch URxvt Daemon (urxvtc to connect)
# We don't launch this through systemd because we cannot execute systemctl
# commands like reboot when logged into a setup started through systemd as the
# client is not part of the session.
urxvtd -q -o -f &


# UniSydney needs this for some reason
# nm-applet &

# Dropbox daemon
dropbox &

# Automount removable drives with udisks
udiskie &

# Better sound server, proxy to alsa
pulseaudio --start &

# Hide cursor when not in use (move to restore)
# Don't include a service file as this depends on xorg.
unclutter &

# Set regular cursor
xsetroot -cursor_name left_ptr &

DEFAULT_ENVIRONMENT=bspwm
environment=${1:-${DEFAULT_ENVIRONMENT}}

case ${environment} in
    bspwm)
        sxhkd &
        exec bspwm
        ;;
    xmonad)
        exec xmonad
        ;;
    gnome)
        # Broken for some reason.
        exec gnome-session
esac
