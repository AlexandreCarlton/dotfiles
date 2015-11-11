#!/bin/bash

[[ -f ${XDG_CONFIG_HOME}/sh/env ]] && . ${XDG_CONFIG_HOME}/sh/env
[[ -f ${XDG_CONFIG_HOME}/sh/profile ]] && . ${XDG_CONFIG_HOME}/sh/profile
[[ -f ${HOME}/.bashrc ]] && . ${HOME}/.bashrc
