#!/bin/sh

# Use vimpager for man pages and other documentation
if [ $(command -v vimpager) ]; then
    alias less="vimpager"
    alias zless="vimpager"
fi

# RVM is used in oh-my-zsh
if [ -d ${HOME}/.oh-my-zsh ]; then
    [ -x "${HOME}/.rvm/scripts/rvm" ] && . "${HOME}/.rvm/scripts/rvm"
fi
