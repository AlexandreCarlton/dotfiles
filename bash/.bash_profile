#!/bin/bash

custom_shell="${HOME}/.local/bin/zsh"

export PATH="${HOME}/.local/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/.local/lib:${LD_LIBRARY_PATH}"


if [[ $- == *i* ]]; then
  if [[ -x "${custom_shell}" ]]; then
    exec "${custom_shell}" -l
  else
    [[ -f "${HOME}/.config/sh/env" ]] && source "${HOME}/.config/sh/env"
    [[ -f "${HOME}/.config/sh/profile" ]] && source "${HOME}/.config/sh/profile"
    [[ -f "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc"
  fi
fi
