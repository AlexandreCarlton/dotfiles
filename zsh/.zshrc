#!/bin/zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ${HOME}/.shrc ]] && source ${HOME}/.shrc

#################################
# Oh-My-Zsh configuration.
# Slow on weaker systems; consider using Prezto (an optimised fork).

# Path to your oh-my-zsh configuration.
ZSH=${HOME}/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/, or use "random" (when oh-my-zsh is loaded)
# ZSH_THEME="agnoster"
# ZSH_THEME="solarized-powerline"
DEFAULT_USER="alexandre"

HIST_STAMPS="dd.mm.yyyy"

# Plugins to load(found in ~/.oh-my-zsh/plugins/*)
plugins=(archlinux \
         battery \
#        emacs \
         git \
         history \
         jsontools \
#        lol \
         python \
         pylint \
         systemd \
         themes)

# Uncomment if you want oh-my-zsh.
source $ZSH/oh-my-zsh.sh

################################
# Prezto (Instantly Awesome Zsh) configuration
# source $HOME/.zprezto/init.zsh


################################
# Base16-shell
# BASE16_SCHEME="solarized"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL


# Make a new status line
[[ -s $HOME/.shell_prompt.sh ]] && source $HOME/.shell_prompt.sh

# Fix whitespace on right prompt
export ZLE_RPROMPT_INDENT=0

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# if [[ -x /usr/bin/cowsay && -x /usr/bin/fortune ]]; then
#     fortune | cowsay # -f elephant-in-snake
# fi
cat /etc/motd
