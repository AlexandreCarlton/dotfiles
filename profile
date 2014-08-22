# If using Zsh and this isn't sourced, then source it in .zprofile with emulate

if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi

# bspwm panel
export PANEL_FIFO="/tmp/panel-fifo"
export PANEL_HEIGHT=16

# User-made utilities (including panel ones)
export PATH="$PATH:/home/alexandre/.bin"

# Cabal (Haskell) installed packages
export PATH="$PATH:/home/alexandre/.cabal/bin"

# Ruby stuff.
export PATH="$PATH:/home/alexandre/.gem/ruby/2.1.0/bin:/root/.gem/ruby/2.1.0/bin"

export EDITOR="vim"
export VISUAL="vim"

# Use Vimpage for man pages and other documentation
if [[ -x /bin/vimpager ]]; then
    export PAGER="/bin/vimpager"
    alias less=$PAGER
    alias zless=$PAGER
else
    export PAGER="less"
fi
# TODO export colours from ~/.Xresources so that things like bar and conky can use them.

# RVM is used in oh-my-zsh
export PATH="$PATH:/home/alexandre/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"



