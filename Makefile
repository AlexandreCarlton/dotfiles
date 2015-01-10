

all: update 

help:
	GNU stow must be installed.

update:
	git pull
	git submodule update --init --recursive

stow:
	sudo ./scripts/install-package.sh stow

hacking: vim-link emacs-link

vim-link: stow update ctags-link
	stow vim
	vim +qall
	vim +"PromptlineSnapshot ~/.shell_prompt.sh airline" +qall

neovim-link: vim-link
	ln -sf ~/.vimrc ~/.nvimrc
	ln -sf ~/.vim ~/.nvim

emacs-link: stow
	stow emacs

ctags-link: stow
	stow ctags

# Shell
shell-link: zsh-link bash-link profile-link

zsh-link: stow
	stow zsh

bash-link: stow
	$(BACKUP_AND_LINK) bashrc
	$(BACKUP_AND_LINK) bash_profile

profile-link:
	$(BACKUP_AND_LINK) profile


# Desktop
desktop-link: bspwm-link xinitrc-link

bspwm-link: stow conky-link X-link bin-link profile-link
	stow bspwm

bin-link:
	$(BACKUP_AND_LINK) bin

conky-link: stow
	$(BACKUP_AND_LINK) conkyrc

X-link: stow
	stow X

fonts-link:
	$(BACKUP_AND_LINK) fonts
	$(BACKUP_AND_LINK) fontconfig config	
	fc-cache vf ~/.fonts
