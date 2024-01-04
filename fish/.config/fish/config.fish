# This is sourced after conf.d/*.

# We wrap stty within `--is-interactive` as fisher will hang otherwise.
if status --is-interactive

  # Autostart sway if it is present - it doesn't like  being run via systemd
  # (Should probably be in a conf.d/sway-autostart.fish file)
  if type -q sway; and [ (tty) = '/dev/tty1' ]; and not set -q DISPLAY; and not set -q TMUX
    set -x WLR_NO_HARDWARE_CURSORS 1
    systemd-cat --identifier=sway sway --unsupported-gpu --verbose
  end

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
