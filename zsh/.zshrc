#!/bin/zsh

#################################
# Oh-My-Zsh configuration.
# Slow on weaker systems; consider using Prezto (an optimised fork).

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/, or use "random" (when oh-my-zsh is loaded)
# Overridden by ~/.shell_prompt.sh
ZSH_THEME="agnoster"
DEFAULT_USER="alexandre"

HIST_STAMPS="dd.mm.yyyy"

# Plugins to load(found in ~/.oh-my-zsh/plugins/*)
plugins=(archlinux \
         battery \
         #emacs \
         git \
         history \
         jsontools \
#        lol \
         python \
         pylint \
         systemd \
         themes)

# Uncomment if you want oh-my-zsh.
source $ZSH/oh-my-zsh.sh

################################
# Prezto (Instantly Awesome Zsh) configuration
# source $HOME/.zprezto/init.zsh


################################
# Base16-shell
# BASE16_SCHEME="solarized"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Pesky permissions - can't get this working.
alias ffs='eval "sudo $(fc -ln -1)"'

# Don't accidentally delete an important directory.
if [[ -x /usr/bin/trash-rm ]]; then
    alias rm='trash'
fi

# Use Vimpage for man pages and other documentation
if [[ -x /bin/vimpager ]]; then
    export PAGER=/bin/vimpager
    alias less=$PAGER
    alias zless=$PAGER
fi

# Make a new status line
[[ -s $HOME/.shell_prompt.sh ]] && . $HOME/.shell_prompt.sh
# Fix whitespace on right prompt
export ZLE_RPROMPT_INDENT=0

# Use vim if available
# if [[ -x /bin/vim ]]; then
#     export EDITOR="vim"
# else
#     export EDITOR="vi"
# fi

# Start R without the startup prompt
alias R="R --quiet"

# Create aliases for nmcli for easy use of wifi.
alias nmcon="nmcli -p con up id"
alias nmlist="nmcli -p dev wifi"

# Easily install AUR packages
alias aurin="sudo aura -Ax"
# Easily upgrade AUR packages
alias aurupg="sudo aura -Akuax"

alias urxvtc_stlarch='urxvtc -letsp 2 -fn "-*-gohufont-medium-*-*-*-11-*-*-*-*-*-iso10646-*","-misc-stlarch-medium-r-normal--10-100-75-75-c-80-iso10646-1"'

alias top="htop"

# User configuration

#export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl"

# export PATH="$PATH:$HOME/.cabal/bin"

# export PATH="$PATH:/usr/bin/vendor_perl"
# export MANPATH="/usr/local/man:$MANPATH"

# export PATH="$PATH:$HOME/.gem/ruby/2.1.0/bin:/root/.gem/ruby/2.1.0/bin"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# Make the example scripts executable - change this later
# export PATH="$PATH:/home/alexandre/.bin"

# if [[ -x /usr/bin/cowsay && -x /usr/bin/fortune ]]; then
#     fortune | cowsay # -f elephant-in-snake
# fi
cat /etc/motd

export PATH="$PATH:$HOME/neo4j-community/bin"
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
