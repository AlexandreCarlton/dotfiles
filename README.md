# Alexandre's dotfiles
These are my config files for easy deployment on new machines.

```bash
    git clone git@github.com:AlexandreCarlton/dotfiles.git ~/.dotfiles
```
Ensure your previous dotfiles are backed up before installing these new ones.

## Installation of dotfiles
First pull in the third-party repositories (e.g. oh-my-zsh) and install GNU stow.
```bash
    cd ~/.dotfiles
    make update
    make stow
```
Use `make help` to see more options.
