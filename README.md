# Alexandre's dotfiles

These are my config files for easy deployment on new machines.

```bash
git clone --recursive --shallow-submodules git@github.com:AlexandreCarlton/dotfiles.git ~/.dotfiles
```
Ensure your previous dotfiles are backed up before installing these new ones.

## Installation of dotfiles
First pull in the third-party repositories (e.g. oh-my-zsh) and install GNU
stow.
```bash
pacman -S stow
cd ~/.dotfiles
make
```

## Consistent theming
As you can probably tell, I'm a big fan of
[Solarized](https://ethanschoover.com/solarized).

If you wish to change this, then the following files will need to be edited:

 - `~/.config/alacritty.yml`
 - `~/.config/gtk-3.0/settings.ini`
 - `~/.config/htop/htoprc` (We won't need to use 'Broken Gray')
 - `~/.config/mako/config`
 - `~/.config/nvim/init.lua`
 - `~/.config/Trolltech.conf`
 - `~/.config/waybar/style.css`

Fontwise, I'm using Hack (bitmap fonts don't work so well on HiDPI screens) and
changing this requires editing almost all the aforementioned files.
