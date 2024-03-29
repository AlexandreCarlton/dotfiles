# Easy way to edit configuration files without knowing where they are (or
# having to type out its XDG path).
# Also to prevent exiting a file and opening it up again with sudo.

alias vimrc "$EDITOR $XDG_CONFIG_HOME/nvim/init.lua"

alias tmuxconf "$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf"

alias pacmanconf "sudo -E $EDITOR /etc/pacman.conf"
alias mirrorlist "sudo -E $EDITOR /etc/pacman.d/mirrorlist"
