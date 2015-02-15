#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f $HOME/.shrc ] && . $HOME/.shrc

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR="vim"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
