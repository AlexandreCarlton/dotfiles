
all: update hacking shell desktop

# Not all that useful really.
help:
	@echo "update		-- Update and pull in third-party repositories"
	@echo ""
	@echo "Programming utilities:"
	@echo "hacking		-- Install all programming dotfiles"
	@echo "vim			-- Install vim dotfiles (.vimrc, .vim/)"
	@echo "neovim		-- Create neovim dotfiles (.nvimrc, .nvim/)"
	@echo "emacs 		-- Install emacs dotfiles (.emacs, .emacs.d/)"
	@echo "ctags 		-- Install ctags dotfile (.ctags)"
	@echo "git 			-- Install git dotfiles (.gitconfig)"
	@echo ""
	@echo "Shell utilities:"
	@echo "zsh			-- Install zsh dotfiles (e.g. .zshrc, .oh-my-zsh)"
	@echo "bash			-- Install bash dotfiles (e.g. .bashrc, .bash_profile)"
	@echo ""
	@echo "Desktop utilities:"
	@echo "desktop  -- Install all related desktop files"
	@echo "bspwm		-- Install bspwm dotfiles (bspwmrc, sxhkdrc)"


##
## Installation of tools and submodules
##

update:
	#git pull --rebase
	git submodule sync
	git submodule update --init #--recursive --remote

##
## Programming utilities
##
hacking: neovim emacs git

vim: ctags
	stow vim
	vim +qall

neovim: vim
	ln -sf ~/.vimrc ~/.nvimrc
	ln -sf ~/.vim ~/.nvim

emacs:
	stow emacs

ctags:
	stow ctags

git:
	stow git

##
## Shell utilities
##
shell: zsh bash

zsh: sh
	stow zsh

bash: sh
	stow bash

sh:
	stow sh

##
## Desktop utilities
##
desktop: X bspwm systemd
	systemctl --user enable desktop.target
	systemctl --user enable chromium
	systemctl --user enable compton
	systemctl --user enable dunst
	systemctl --user enable dropbox
	systemctl --user enable wallpaper@PikachuEevee.png
	systemctl --user enable pulseaudio
	systemctl --user enable redshift
	systemctl --user enable steam
	systemctl --user enable udiskie
	systemctl --user enable unclutter

bspwm: conky X binaries systemd
	stow bspwm
	systemctl --user enable bspwm # includes sxhkd

tmux: systemd
	stow tmux
	systemctl --user enable tmux

binaries:
	stow binaries

conky:
	stow status

X: systemd
	stow X
	systemctl --user enable rofi
	systemctl --user enable urxvtd.socket
	systemctl --user enable xorg
	systemctl --user enable xrdb
	systemctl --user enable bell
	systemctl --user enable cursor

systemd:
	stow systemd
