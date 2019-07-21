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

bspwm: X
	stow bspwm
	systemctl --user enable bspwm-session.target
.PHONY: bspwm

chromium:
	stow chromium
	systemctl --user enable chromium
.PHONY: chromium

dunst:
	stow dunst
	systemctl --user enable dunst
.PHONY: dunst

jetbrains:
	stow jetbrains
	# systemctl --user enable intellij-idea-ce
.PHONY: jetbrains

redshift:
	stow redshift
	systemctl --user enable redshift
.PHONY: redshift

steam:
	stow steam
	# systemctl --user enable steam
.PHONY: steam

tmux:
	stow tmux
	systemctl --user enable tmux
.PHONY: tmux

vim:
	stow vim
	vim +PlugInstall +qall
.PHONY: vim

wallpaper:
	stow wallpaper
	systemctl --user enable wallpaper@PikachuEevee.png

X:
	stow X
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

development: jetbrains tmux vim
	stow ctags
	stow docker
	stow fzf
	stow go
	stow editorconfig
	stow fish
	stow ghc
	stow git
	stow less
	stow htop
	stow javascript
	stow python
	stow sh
	stow systemd
	stow ssh

desktop: development bspwm chromium dunst redshift wallpaper X
	stow binaries
	stow dunst
	stow fontconfig
	stow gtk
	stow mime
	stow mpv
	stow pacman
	stow psd
	stow qt
	stow retroarch
	stow zathura
