#!/bin/sh

# Creates symlinks to dotfiles while backing up old ones
# Sets up Vim packages


DIR=~/.dotfiles
OLDDIR=~/.dotfiles_old
FILES="bash_profile gitconfig vimrc"
FOLDERS="vim"
MERGE_FOLDERS="config" # Folders that have things in them we want to keep.

echo "Creating $OLDDIR for backup of existing dotfiles..."
mkdir -p $OLDDIR
echo "Finished creating $OLDDIR ."


##################################################
#                                                #
# Backup & Symlink                               #
#                                                #
##################################################

echo "Commencing backup and linking of files and folders..."
for file in $FILES $FOLDERS; do

    if [ -e ~/.$file ]; then
        echo "Moving existing ~/.$file to $OLDDIR ..."
        mv ~/.$file $OLDDIR
    fi

    echo "Creating symlink of $file ..."
    ln -s $DIR/$file ~/.$file

done
echo "Finished backup into $OLDDIR and linking."


##################################################
#                                                #
# NeoBundle                                      #
#                                                #
##################################################

# Note: oh-my-zsh can automatically install vundle for you.

BUNDLE_FOLDER=~/.vim/bundle
BUNDLE_MANAGER=neobundle.vim
BUNDLE_AUTHOR=Shougo
INSTALL_BUNDLES=NeoBundleInstall

echo "Setting up $BUNDLE_MANAGER plugin ..."
if [ ! -d $BUNDLE_FOLDER/$BUNDLE_MANAGER/.git/ ]; then

    echo "Creating $BUNDLE_FOLDER ..."
    mkdir -p $BUNDLE_FOLDER

    echo "Cloning bundle manager into ~/.vim/bundle/neobundle.vim..."
    git clone https://github.com/$BUNDLE_AUTHOR/$BUNDLE_MANAGER $BUNDLE_FOLDER/$BUNDLE_MANAGER 

    echo "Finished setting up $BUNDLE_MANAGER plugin."
else
    echo "$BUNDLE_MANAGER already installed."
fi

echo "Installing bundles ..."
vim +$INSTALL_BUNDLES +qall

##################################################
#                                                #
# Powerline fonts                                # 
#                                                #
##################################################

FONTS=~/.fonts
FONTS_CONF=~/.fonts.conf.d # Check if you should use ~/.config/fontconfig/conf.d
SYMBOLS=PowerlineSymbols.otf
SYMBOLS_CONF=10-powerline-symbols.conf
FONT_URL=https://github.com/Lokaltog/powerline/raw/develop/font

echo "Creating $FONTS ..."
mkdir -p $FONTS

echo "Downloading $SYMBOLS ..."
curl -L $FONT_URL/$SYMBOLS > $FONTS/$SYMBOLS
fc-cache -vf $FONTS

echo "Creating $FONTS_CONF ..."
mkdir -p $FONTS_CONF 

echo "Downloading $SYMBOLS_CONF ..."
curl -L $FONT_URL/$SYMBOLS_CONF > $FONTS_CONF/$SYMBOLS_CONF


##################################################
#                                                #
# Promptline                                     #
#                                                #
##################################################

echo "Setting up Promptline if included..."
if [ ! -d ~/.vim/bundle/promptline.vim ]; then
    echo "Promptline not included in .vimrc, skipping setting..."
else
    echo "Promptline included in .vimrc, setting up..."
    vim +"PromptlineSnapshot ~/.shell_prompt.sh" +qall
fi

# Apply settings to current session
# . ~/.bash_profile
