
all: update install-stow install-dash hacking shell-link

# Not all that useful really.
help:
	@echo "update		-- Update and pull in third-party repositories"
	@echo "install-stow	-- Install GNU stow from official repositories"
	@echo "install-dash	-- Install dash (a small, fast POSIX shell) from official repositories"
	@echo "link-fonts   -- Install fonts (e.g. Powerline)"
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
	git submodule update --init --recursive

# make these aliases, like install-stow=/usr/bin/stow
/usr/bin/stow:
	@echo "Installing stow."
	sudo sh scripts/install-package.sh stow

install-stow: /usr/bin/stow

/bin/dash:
	@echo "Installing and linking dash."
	sudo sh scripts/install-package.sh dash
	sudo ln -sfT /bin/dash /bin/sh

install-dash: /bin/dash

/bin/zsh:
	@echo "Installing and changing shell to zsh."
	sudo sh scripts/install-package.sh zsh
	sudo chsh -s /bin/zsh

##
## Programming utilities
##
hacking: neovim-link emacs-link git-link

vim-link: install-stow update ctags-link
	stow vim
	vim +qall
	vim +"PromptlineSnapshot! ~/.shell_prompt.sh airline" +qall

neovim-link: vim-link
	ln -sf ~/.vimrc ~/.nvimrc
	ln -sf ~/.vim ~/.nvim

emacs-link: install-stow
	stow emacs

ctags-link: install-stow
	stow ctags

git-link: install-stow
	stow git

##
## Shell utilities
##
shell-link: zsh-link bash-link sh-link

zsh-link: install-stow sh-link
	stow zsh

bash-link: install-stow sh-link
	stow bash

sh-link: install-stow
	stow sh

##
## Desktop utilities
##
desktop-link: bspwm-link xinitrc-link

bspwm-link: install-stow conky-link X-link bin-link profile-link
	stow bspwm

tmux-link: vim-link
	stow tmux
	tmux new-session 'vim +"Tmuxline airline | TmuxlineSnapshot! ~/.tmuxline.conf" +qall'

bin-link:
	$(BACKUP_AND_LINK) bin

conky-link: install-stow
	stow conky

X-link: install-stow
	stow X

link-fonts: install-stow
	stow font
	fc-cache vf ~/.fonts

systemd: install-stow
	stow --ignore="*.md" systemd
	systemctl --user enable udiskie
	# Don't need a service file for dropbox or pulseaudio, it's included
	# systemctl --user enable dropbox
	systemctl --user enable pulseaudio
	systemctl --user enable tmux
	systemctl --user enable udiskie
	systemctl --user enable wm.target
	systemctl --user enable bspwm # includes sxhkd
	systemctl --user enable xorg
	systemctl --user enable xrdb
	systemctl --user enable xset
	systemctl --user enable xsetroot
	systemctl --user enable wallpaper
	systemctl --user enable dunst
	systemctl --user enable unclutter
