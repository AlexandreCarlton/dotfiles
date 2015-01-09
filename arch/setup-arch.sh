#!/bin/bash

function build_aur () {
    package=$1
    index=${package:0:2}
    tarball=${package}.tar.gz

    cd $HOME
    wget https://aur.archlinux.org/packages/$index/$package/$tarball
    tar -xzvf $tarball
    cd $package
    makepkg -si

    # Clean up
    cd $HOME
    rm $tarball
    rm -r $package
}

export $EDITOR=vi

cd $HOME

# Install official packages (removing comments)
pacman -S $(sed s/#.*//g $HOME/.dotfiles/arch/packages-official.txt)

# Install precompiled aura (no hellish haskell dependencies)
build_aur aura-bin


cd $HOME
# Setup dotfiles
chmod u+x $HOME/.dotfiles/setup-dotfiles.sh
$HOME/.dotfiles/setup-dotfiles.sh

# Enable Gnome Display Manager (login screen)
systemctl enable gdm.service 
#systemctl enable slim.service 

# Set Chromium as default web browser
xdg-mime default chromium.desktop x-scheme-handler/http
xdg-mime default chromium.desktop x-scheme-handler/https

# Set zsh as default shell
chsh -s /bin/zsh
