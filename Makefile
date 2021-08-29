all: development desktop

update-submodules:
	#git pull --rebase
	git submodule sync
	git submodule update --init --recursive --remote

development:
	stow alacritty
	stow bat
	stow ccache
	stow ctags
	stow docker
	stow editorconfig
	stow efm-langserver
	stow fish
	stow fzf
	stow ghc
	stow git
	stow go
	stow htop
	stow jetbrains
	stow less
	stow maven
	stow npm
	stow python
	stow R
	stow ripgrep
	stow sh
	stow ssh
	stow systemd
	stow tmux
	stow vim
.PHONY: development

desktop: development
	stow chromium
	stow fontconfig
	stow gammastep
	stow gtk
	stow kanshi
	stow mime
	stow mpv
	stow mako
	stow pacman
	stow polybar
	stow psd
	stow qt
	stow redshift
	stow retroarch
	stow swappy
	stow sway
	stow swaylock
	stow wallpaper
	stow waybar
	stow zathura
	stow zoom
.PHONY: desktop

hidpi:
	stow --override=.config hidpi
.PHONY: hidpi
