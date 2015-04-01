#!/bin/sh

# Distro-agnostic script to install a program.

if [ "$#" = "0" ]; then
    echo 'Please specify at least one package to install.'
    return
fi

programs=$@
OS=$(cat /etc/*-release | grep '^ID=' | sed 's/.*=//g')


case ${OS} in
    arch)
        pacman -S ${programs}
        ;;
    ubuntu)
        apt-get install ${programs}
        ;;
    fedora)
        yum install ${programs}
        ;;
esac
