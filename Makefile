
.PHONY = all help update stow linuxbrew ruby desktop development

all: update linuxbrew desktop development

# Not all that useful really.
help:
	@echo "update		   -- Update and pull in third-party repositories"
	@echo "stow  		   -- Install stow locally from source"
	@echo "ruby 		   -- Install ruby locally from source (for linuxbrew)"
	@echo "linuxbrew   -- Install linuxbrew in ${HOME}/.linuxbrew"
	@echo "development -- Install development dotfiles with stow"
	@echo "desktop     -- Install desktop dotfiles with stow"


##
## Installation of tools and submodules
##

update-submodules:
	#git pull --rebase
	git submodule sync
	git submodule update --init --recursive --remote

stow:
	sh scripts/install-stow.sh

# In case it is not recent enough for linuxbrew.
ruby:
	sh scripts/install-ruby.sh

linuxbrew:
	git clone git://github.com/Homebrew/linuxbrew.git ${HOME}/.linuxbrew
	. sh/.config/sh/path
	brew install stow
	brew install vim
	brew install tmux
	brew install zsh
	brew install the_silver_searcher

development:
	stow ccache
	stow ctags
	stow editorconfig
	stow ghc
	stow git
	stow htop
	stow python
	stow sh
	stow spacemacs
	stow ssh
	stow systemd
	stow tmux
	stow vim
	stow zsh

# TODO: Find a way to ensure stow is in $PATH
desktop: development
	stow binaries
	stow bspwm
	stow colours
	stow dunst
	stow fontconfig
	stow gtk
	stow mime
	stow mpv
	stow psd
	stow qt
	stow redshift
	stow retroarch
	stow steam
	stow X
	stow zathura
