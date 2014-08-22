#!/bin/sh

# Backs up and symlinks files

# usage: ./backup.sh vim
# usage: ./backup.sh bspwm config

# backs up a given file to .dotfiles_old
# if that file already exists in .dotfiles_old (or it is a symlink), it is ignored.
# would have put this in the makefile but make syntax is fiddly.

file=$1
optional_folder=$2 # where the file is to go.

backup_folder=$(pwd)_backup
mkdir -p $backup_folder

if [[ -n "$optional_folder" ]]; then
    filepath=$HOME/.$optional_folder/$file
else
    filepath=$HOME/.$file
fi

# if the file already exists then we back it up,
# move it into the folder with a timestamp (allows for multiple versions)
if [[ -e $filepath ]]; then
    # Can be relatively certain that this is unique,
    # unless we call this twice on the same item in the same nanosecond.
    timestamp=$(date +"%Y%m%d-%H%M%S-%N")
    backup_filepath=$backup_folder/${file}_${timestamp}
    mv $filepath $backup_filepath
fi

# Perform the link, now that we've safely backed up the original.
ln -s $(pwd)/$file $filepath
