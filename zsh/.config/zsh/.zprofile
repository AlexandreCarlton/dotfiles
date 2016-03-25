#!/bin/zsh

# Should really use .zlogin instead; this is meant to appeal to ksh fans

[[ -s "${XDG_CONFIG_HOME}/sh/profile" ]] \
  && source "${XDG_CONFIG_HOME}/sh/profile"
