#!/bin/zsh

# Should really use .zlogin instead; this is meant to appeal to ksh fans

profile="${XDG_CONFIG_HOME}/sh/profile"
[[ -f "${profile}" ]] && . "${profile}"
