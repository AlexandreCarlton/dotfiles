
all: update install-dash hacking shell-link

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
	@echo "bspwm		-- Install bspwm dotfiles (bspwmrc, sxhkdrc)"
	@echo "xmonad		-- Install xmonad dotfiles (.xmonad.hs)"



##
## Installation of tools and submodules
##

update:
	git pull --rebase
	git submodule update --init --recursive --remote

##
## Programming utilities
##
hacking: neovim-link emacs-link git-link

vim-link: update ctags-link
	stow vim
	vim +qall
	#vim +"PromptlineSnapshot! ~/.shell_prompt.sh airline" +qall

neovim-link: vim-link
	ln -sf ~/.vimrc ~/.nvimrc
	ln -sf ~/.vim ~/.nvim

emacs-link:
	stow emacs

ctags-link:
	stow ctags

git-link:
	stow git

##
## Shell utilities
##
shell-link: zsh-link bash-link sh-link

zsh-link: sh-link
	stow zsh

bash-link: sh-link
	stow bash

sh-link:
	stow sh

##
## Desktop utilities
##
desktop-link: bspwm-link xinitrc-link

bspwm-link: conky-link X-link bin-link profile-link
	stow bspwm

tmux-link: vim-link
	stow tmux

bin-link:
	$(BACKUP_AND_LINK) bin

conky-link:
	stow conky

X-link:
	stow X

systemd:
	stow systemd
	systemctl --user enable desktop.target
	systemctl --user enable bspwm # includes sxhkd
	systemctl --user enable xorg
	# Desktop utilities.
	systemctl --user enable chromium
	systemctl --user enable compton
	systemctl --user enable dbus.socket
	systemctl --user enable dunst
	# systemctl --user enable dropbox
	systemctl --user enable feh@PikachuEevee.png
	systemctl --user enable pulseaudio
	systemctl --user enable redshift
	systemctl --user enable tmux
	systemctl --user enable udiskie
	systemctl --user enable unclutter
	systemctl --user enable urxvtd.socket
	systemctl --user enable xrdb
	systemctl --user enable xset
	systemctl --user enable xsetroot
