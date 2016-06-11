#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Attach to Tmux as early as possible.
[[ -s "${HOME}/.config/sh/shrc" ]] \
  && source "${HOME}/.config/sh/shrc"

# Prezto setup
[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] \
  && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"


# Consider using Zim, seems to be a more minimal Prezto.
# Or Zgen, as we can add plugins from other frameworks; way more flexible.
