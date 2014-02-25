#!/bin/sh

# Creates symlinks to dotfiles while backing up old ones.
# Set up Vim packages

# Largely stolen from michaeljsmalley


dir=~/.dotfiles
olddir=~/.dotfiles_old
files="bashrc bash_profile gitconfig vimrc vim"


echo "Creating $olddir for backup of existing dotfiles..."
mkdir -p $olddir

echo "Commencing backup and linking of files..."
for file in $files; do

    if [ -f ~/.$file ]; then
        echo "Moving existing ~/.$file to $olddir ..."
        mv ~/.$file $olddir
    fi

    echo "Creating symlink of $file ..."
    ln -s $dir/$file ~/.$file

done
echo "Finished backup and linking."




# Setup Vundle plugins
if [ ! -d ~/.vim/bundle/vundle ]; then

    echo "Creating ~/.vim/bundle if not already present..."
    mkdir -p ~/.vim/bundle

    echo "Cloning Vundle into ~/.vim/bundle/vundle..."
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

echo "Installing Vundle packages..."
vim +BundleInstall +qall


# Setup promptline if it was included.
if [ ! -d ~/.vim/bundle/promptline.vim ]; then
    echo "Promptline not included in .vimrc, skipping setting..."
else
    echo "Setting up Promptline... "
    vim +"PromptlineSnapshot ~/.shell_prompt.sh airline" +qall
fi

# Apply settings to current session
# . ~/.bash_profile
