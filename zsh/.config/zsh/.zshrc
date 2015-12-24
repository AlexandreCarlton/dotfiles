#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Attach to Tmux as early as possible.
[[ -f ${HOME}/.config/sh/shrc ]] && source ${HOME}/.config/sh/shrc

# oh-my-zsh
# ZSH_THEME="avit"

# Prezto setup
[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] \
  && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
