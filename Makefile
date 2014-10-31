
# Idea: set up dotfiles more easily.
# make install-vim-bundle: Installs neobundle.
# make install-vim: installs installs vim-bundle, backs up vimrc and vim/,
# and installs everything (ctags, vim, vimrc, calls vim +NeoBundleInstall, etc.)
#
# make desktop - symlinks Xresources, etc.

# We don't want these to represent physical files - perhaps rename to install-x?
# or x-link
#.PHONY: vim backup update fonts zsh
# could change usage to accept variable number of arguments
# and specify a --folder=<folder>, which it would be placed in instead of ~
# so: $(BACKUP_AND_LINK) bspwm sxhkd --folder=config for example.
BACKUP_AND_LINK=sh `pwd`/scripts/backup_and_link.sh

all:
	@echo "called all"
	@echo "lol"

help:
	echo "THINGS"

update:
	git pull
	git submodule update --init --recursive

hacking: vim-link emacs-link

vim-link: update ctags-link
	$(BACKUP_AND_LINK) vimrc
	$(BACKUP_AND_LINK) vim
	vim +qall
	vim +"PromptlineSnapshot ~/.shell_prompt.sh" +qall

neovim-link: vim-link
	ln -sf ~/.vimrc ~/.nvimrc
	ln -sf ~/.vim ~/.nvim


emacs-link:
	$(BACKUP_AND_LINK) emacs.d

ctags-link:
	$(BACKUP_AND_LINK) ctags

# Shell
shell-link: zsh-link bash-link profile-link

zsh-link:
	$(BACKUP_AND_LINK) zshrc
	$(BACKUP_AND_LINK) oh-my-zsh
	$(BACKUP_AND_LINK) zprezto
	$(BACKUP_AND_LINK) zpreztorc

bash-link:
	$(BACKUP_AND_LINK) bashrc
	$(BACKUP_AND_LINK) bash_profile

profile-link:
	$(BACKUP_AND_LINK) profile


# Desktop
desktop-link: bspwm-link xinitrc-link

bspwm-link: conky-link xresources-link bin-link profile-link
	$(BACKUP_AND_LINK) bspwm config
	$(BACKUP_AND_LINK) sxhkd config

bin-link:
	$(BACKUP_AND_LINK) bin

conky-link:
	$(BACKUP_AND_LINK) conkyrc

X-link:
	$(BACKUP_AND_LINK) palettes
	$(BACKUP_AND_LINK) Xresources
	$(BACKUP_AND_LINK) xinitrc

fonts-link:
	echo "TODO"
