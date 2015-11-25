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


# Remove beep
xset b off &

# Don't fork this; pretty crucial.
[ -r ${HOME}/.Xresources ] && xrdb -load ${HOME}/.Xresources

# TODO source ~/bin/export_colours.sh,
# Start dunst specifying the colours and fonts
# - sourcing everything in xinitrc.d/ usually starts it for us.
# See if you can get a dmenu daemon running with these parameters as well.

# Set background
feh --verbose --no-fehbg -bg-fill ${HOME}/.wallpaper/PikachuEevee.png &

# Launch URxvt Daemon (urxvtc to connect)
urxvtd -o -f

# Notifications
dunst &

# Dropbox daemon
dropbox &

# Launcher
rofi -key-run mod4-space

# Prevent eyes from bleeding
redshift &

# Hide cursor when not in use (move to restore)
# Don't include a service file as this depends on xorg.
unclutter &

# Set regular cursor
xsetroot -cursor_name left_ptr &

# Tmux
tmux -f ${HOME}/.config/tmux/tmux.conf new-session -d -s alexandre

sxhkd &

${HOME}/.bin/panel bar

exec bspwm
