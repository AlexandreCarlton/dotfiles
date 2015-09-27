#!/bin/zsh

# TODO: This is getting sourced 3 times. Figure out why.
#export SOURCE_ZSHENV=$((SOURCE_ZSHENV + 1))

[[ -f ${HOME}/.config/sh/env ]] && source ${HOME}/.config/sh/env
