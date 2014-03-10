# Alexandre's dotfiles
These are my config files for easy deployment on new machines.

```bash
    git clone git@github.com:AlexandreCarlton/dotfiles.git ~/.dotfiles
```

## Installation of dotfiles
All pre-existing dotfiles that conflict with the ones in this repo will be stored in a backup directory for easy reversion.

```bash
    chmod u+x ~/.dotfiles/setup-dotfiles.sh
    ~/.dotfiles/setup-dotfiles.sh
```

## Installation on a new system (WIP)
If you have just installed one of these distributions:

 - Arch

Then you may install a list of software that I use a great deal (along with settings that can be done via the command line).
```bash
    chmod u+x ~/.dotfiles/setup-dotfiles.sh
    chmod u+x ~/.dotfiles/<distro>/setup-<distro>.sh
    ~/.dotfiles/<distro>/setup-<distro>.sh
```
This will also install the dotfiles, rending the previous instruction moot.
