#!/bin/sh

# Creates symlinks to dotfiles while backing up old ones
# Sets up Vim packages


DIR=~/.dotfiles
OLDDIR=~/.dotfiles_old
FILES="bash_profile gitconfig vimrc"
FOLDERS="vim"


echo "Creating $OLDDIR for backup of existing dotfiles..."
mkdir -p $OLDDIR
echo "Finished creating $OLDDIR ."


echo "Creating folders if they don't already exist..."
for folder in $FOLDERS; do
    mkdir -p dir/$folder
done
echo "Finished creating folders."


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


echo "Setting up Vundle plugin..."
if [ ! -d ~/.vim/bundle/vundle ]; then

    echo "Creating ~/.vim/bundle if not already present..."
    mkdir -p ~/.vim/bundle

    echo "Cloning Vundle into ~/.vim/bundle/vundle..."
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

    echo "Finished setting up Vundle plugin."
else
    echo "Vundle already installed."
fi

echo "Installing Vundle packages..."
vim +BundleInstall +qall


echo "Setting up Promptline if included..."
if [ ! -d ~/.vim/bundle/promptline.vim ]; then
    echo "Promptline not included in .vimrc, skipping setting..."
else
    echo "Promptline included in .vimrc, setting up..."
    vim +"PromptlineSnapshot ~/.shell_prompt.sh airline" +qall
fi

# Apply settings to current session
# . ~/.bash_profile
