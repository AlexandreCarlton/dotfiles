all: development desktop

update-submodules:
	#git pull --rebase
	git submodule sync
	git submodule update --init --recursive --remote

development:
	stow ctags
	stow docker
	stow fzf
	stow go
	stow editorconfig
	stow fish
	stow ghc
	stow git
	stow jetbrains
	stow less
	stow htop
	stow npm
	stow python
	stow sh
	stow systemd
	stow ssh
	stow tmux
	stow vim
.PHONY: development

desktop: development
	stow binaries
	stow bspwm
	stow chromium
	stow dunst
	stow fontconfig
	stow gtk
	stow mime
	stow mpv
	stow pacman
	stow polybar
	stow psd
	stow redshift
	stow qt
	stow retroarch
	stow wallpaper
	stow X
	stow zathura
.PHONY: desktop

hidpi:
	stow --override=.config hidpi
.PHONY: hidpi
