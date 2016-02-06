all: update linuxbrew

# Not all that useful really.
help:
	@echo "update		 -- Update and pull in third-party repositories"
	@echo "ruby 		 -- Install ruby in ${HOME}/.local/bin (for linuxbrew)"
	@echo "linuxbrew -- Install linuxbrew in ${HOME}/.linuxbrew"


##
## Installation of tools and submodules
##

update:
	#git pull --rebase
	git submodule sync
	git submodule update --init --recursive --remote

linuxbrew:
	git clone git://github.com/Homebrew/linuxbrew.git ${HOME}/.linuxbrew
	. sh/.config/sh/path
	brew install stow
	brew install vim
	brew install tmux
	brew install zsh
	brew install the_silver_searcher

# In case it is not recent enough for linuxbrew.
ruby:
	sh scripts/install-ruby.sh
