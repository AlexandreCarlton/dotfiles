#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTFILE="${XDG_DATA_HOME}/bash/history"

[[ -f "${XDG_CONFIG_HOME}/sh/shrc" ]] && . "${XDG_CONFIG_HOME}/sh/shrc"

PS1='[\u@\h \W]\$ '
