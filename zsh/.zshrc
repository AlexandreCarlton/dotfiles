#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ${HOME}/.shrc ]] && source ${HOME}/.shrc

# Oh-My-Zsh configuration.
# Slowly transition away from this; it's nice but slow.

# Path to your oh-my-zsh configuration.
ZSH=${HOME}/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/, or use "random" (when oh-my-zsh is loaded)
# ZSH_THEME="agnoster"
DEFAULT_USER="alexandre"

HIST_STAMPS="dd.mm.yyyy"

# Plugins to load(found in ~/.oh-my-zsh/plugins/*)
plugins=(archlinux \
#        emacs \
         git \
         history \
         python \
         pylint \
         systemd \
         themes \
         )

# Uncomment if you want oh-my-zsh.
source $ZSH/oh-my-zsh.sh

# Uncomment if you want prezto.
# source $HOME/.zprezto/init.zsh

# Make a new status line
PROMPT_FILE=${HOME}/.promptline.sh
[[ -s $PROMPT_FILE ]] && source $PROMPT_FILE

# Fix whitespace on right prompt
export ZLE_RPROMPT_INDENT=1

