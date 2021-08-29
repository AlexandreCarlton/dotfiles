all: development desktop

update-submodules:
	#git pull --rebase
	git submodule sync
	git submodule update --init --recursive --remote

development:
	stow ctags
	stow docker
	stow efm-langserver
	stow fzf
	stow go
	stow editorconfig
	stow fish
	stow ghc
	stow git
	stow jetbrains
	stow less
	stow htop
	stow maven
	stow npm
	stow python
	stow ripgrep
	stow sh
	stow systemd
	stow ssh
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
.PHONY: desktop

hidpi:
	stow --override=.config hidpi
.PHONY: hidpi
