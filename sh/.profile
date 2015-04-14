#!/bin/sh

# See if this fixes panel not launching
. $HOME/.env

# Systemd!
#/usr/lib/systemd/systemd --user &

# RVM is used in oh-my-zsh
if [ -d ${HOME}/.oh-my-zsh ]; then
    [ -x "${HOME}/.rvm/scripts/rvm" ] && . "${HOME}/.rvm/scripts/rvm"
fi
