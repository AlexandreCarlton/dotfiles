#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTFILE="$XDG_DATA_HOME/bash/history"

[ -f $HOME/.config/sh/shrc ] && . $HOME/.config/sh/shrc

PS1='[\u@\h \W]\$ '
