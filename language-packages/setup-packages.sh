#!/bin/bash

# Installs preset packages using respective managers.
# Assumes method of installing them is "install"

PACKAGES="pip"

for package in $PACKAGES; do
    echo $package install $(sed s/#.*//g $package-packages.txt)
done

# TODO remove the generated build directory
