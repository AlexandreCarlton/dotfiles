
.PHONY = all update desktop development

all: development desktop

test:
	docker build \
		--build-arg user=alexandre \
		--pull \
		--tag=alexandrecarlton/dotfiles \
		.
	docker run \
		--detach \
		--name=dotfiles-fixture \
		--rm \
		--mount=type=bind,source=$(shell pwd),destination=/home/alexandre/.dotfiles,readonly \
		--mount=type=bind,source=/sys/fs/cgroup,destination=/sys/fs/cgroup,readonly \
		--mount=type=tmpfs,tmpfs-size=512M,destination=/run \
		--mount=type=tmpfs,tmpfs-size=256M,destination=/tmp \
		--workdir=/home/alexandre/.dotfiles \
		alexandrecarlton/dotfiles
	# Afford the container time to start up.
	sleep 10
	docker exec \
		--tty \
		dotfiles-fixture \
			'make'
	docker kill dotfiles-fixture
.PHONY: test

# TODO: Make this a macro? with params for no-folding, and enabling.
bspwm: X
	stow --no-folding bspwm
	systemctl --user enable bspwm-session.target
.PHONY: bspwm

chromium:
	stow --no-folding chromium
	systemctl --user enable chromium
.PHONY: chromium

X:
	stow --no-folding X
	systemctl --user enable \
		bell \
		cursor \
		unclutter \
		urxvtd.socket \
		xrdb \
		x11.socket
	# Start eagerly since we always use it.
	# This failed with:
	#     Failed to enable unit, refusing to operate on linked unit file urxvtd.socket
	# systemctl --user enable urxvtd
	# Hack to ensure xorg is started up before applications connect to it.
	# (Socket activation is broken.)
	systemctl --user enable xorg-delay@5
.PHONY: X

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
desktop: bspwm chromium development
	stow --no-folding binaries
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
