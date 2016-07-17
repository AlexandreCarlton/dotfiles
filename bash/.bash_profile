#!/bin/bash

custom_shell="${HOME}/.local/bin/zsh"

if [[ -x "${custom_shell}" ]]; then
  exec "${custom_shell}" -l
else
  [[ -f "${HOME}/.config/sh/env" ]] && source "${HOME}/.config/sh/env"
  [[ -f "${HOME}/.config/sh/profile" ]] && source "${HOME}/.config/sh/profile"
  [[ -f "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc"
fi
