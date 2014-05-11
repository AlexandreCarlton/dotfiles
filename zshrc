# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


# Source .xinitrc if login manager (like gdm) skips it
#if [[ -n "$XINITRC_LOADED" ]]; then
#    source ~/.xinitrc
#fi

# Use Vimpage for man pages and other documentation
if [[ -x /bin/vimpager ]]; then
    export PAGER=/bin/vimpager
    alias less=$PAGER
    alias zless=$PAGER
fi

# Make a new status line
if [[ -e $HOME/.shell_prompt.sh ]]; then
    source $HOME/.shell_prompt.sh
fi

#Use vim if available
if [[ -x /bin/vim ]]; then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

# Start R without the startup prompt
alias R="R --quiet"

# Look in ~/.oh-my-zsh/themes/, or use "random" (when oh-my-zsh is loaded)
ZSH_THEME="robbyrussell"

HIST_STAMPS="dd.mm.yyyy"

# Plugins to load(found in ~/.oh-my-zsh/plugins/*)
plugins=(git archlinux systemd history themes battery python pylint)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl"

export PATH="$HOME/.cabal/bin:$PATH"

export PATH="/usr/bin/vendor_perl:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

export PATH="$HOME/.gem/ruby/2.1.0/bin:$PATH"
export PATH="/root/.gem/ruby/2.1.0/bin:$PATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Make the example scripts executable - change this later
export PATH=$PATH:/home/alexandre/panel_scripts
