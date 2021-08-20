# This is sourced after conf.d/*.

# We wrap stty within `--is-interactive` as fisher will hang otherwise.
if status --is-interactive

  for aliases in $HOME/.config/fish/aliases/*
    source $aliases
  end

  # Disable Ctrl-S freezing the terminal
  stty -ixon

  # Suppress the greeting (Welcome to fish, the friendly interactive shell)
  set --universal fish_greeting

  # See CTRL-R / CTRL-T
  fzf_key_bindings

  # Some applications require JAVA_HOME; however, we may need to change it,
  # which is why it is not set from environment.d
  set -gx JAVA_HOME /usr/lib/jvm/default

end
