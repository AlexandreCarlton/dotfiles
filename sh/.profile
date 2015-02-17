#!/bin/sh

# RVM is used in oh-my-zsh
if [ -d ${HOME}/.oh-my-zsh ]; then
    [ -x "${HOME}/.rvm/scripts/rvm" ] && . "${HOME}/.rvm/scripts/rvm"
fi
