
.PHONY = all update desktop development

all: update desktop-systemd

update-submodules:
	#git pull --rebase
	git submodule sync
	git submodule update --init --recursive --remote

development:
	stow --no-folding ccache
	stow chromium
	stow ctags
	stow docker
	stow go
	stow editorconfig
	stow --no-folding fish
	stow --no-folding ghc
	# It is crucial there is no folding for git otherwise our templates will be
	# symlinks to invalid locations.
	stow git
	stow less
	stow htop
	stow javascript
	stow --no-folding python
	stow R
	stow sh
	stow spacemacs
	stow --no-folding systemd
	stow --no-folding ssh
	stow --no-folding tmux
	stow --no-folding vim
	stow --no-folding zsh

development-systemd:
	stow --no-folding systemd
	systemctl --user enable tmux

# TODO: Find a way to ensure stow is in $PATH
desktop: development
	stow --no-folding binaries
	stow bspwm
	stow dunst
	stow fontconfig
	stow gtk
	stow konsole
	stow mime
	stow mpv
	stow pacman
	stow psd
	stow qt
	stow redshift
	stow --no-folding retroarch
	stow steam
	stow X
	stow --no-folding wallpaper
	stow zathura

desktop-systemd: desktop development-systemd
	stow --no-folding systemd
	systemctl --user enable bell
	systemctl --user enable bspwm
	systemctl --user enable chromium
	systemctl --user enable cursor
	systemctl --user enable dunst
	systemctl --user enable lightstatus.socket
	systemctl --user enable lemonbar.socket
	systemctl --user enable redshift
	systemctl --user enable unclutter
	systemctl --user enable wallpaper@PikachuEevee.png
	systemctl --user enable urxvtd.socket
	systemctl --user enable xrdb
	# Eagerly launch things
	systemctl --user enable urxvtd.service
	systemctl --user enable x11.socket
	# Hack until systemd fixes xorg socket activation in systemd
	systemctl --user enable xorg-delay@5
