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
    make update-submodules
```
Use `make help` to see more options.

## Consistent theming
As you can probably tell, I'm a big fan of
[Solarized](https://ethanschoover.com/solarized).

If you wish to change this, then the following files will need to be edited:

 - ~/.config/bspwm/lemonbar.conf
 - ~/.config/dunst/dunstrc
 - ~/.config/gtk-3.0/settings.ini
 - ~/.config/htop/htoprc (We won't need to use 'Broken Gray')
 - ~/.config/nvim/init.vim
 - ~/.config/spacemacs/init.el
 - ~/.config/Trolltech.conf
 - ~/.config/X11/Xresources
 - ~/.gtkrc-2.0
 - ~/.local/share/konsole/Alexandre.profile

Fontwise, I'm using GohuFont and changing this requires editing all
the aforementioned files bar `init.vim` and `htoprc`.
At some point I'll add this as a submodule to ~/.fonts.
Right now I'm not using Powerline fonts; they were too much trouble to get
working with URxvt (I had to install a second patched-font which was rather
inelegant).
I'll consider using it in the future if PowerlineSymbols.otf doesn't mess with
URxvt.

## Troubleshooting
This is for personal reference when I inevitably break something and can't
easily fix it.
You'll need to boot into another run level (normally 3) by appending "1"
(without quotations) to the kernel command line:
```
    kernel /vmlinz-linux ... root=/dev/sda2 ro 1
```
Then you can revert any changes as root.
You can change the boot level by going into the Advanced options.
You can change user with `su - <username>` if necessary (e.g. switching git
branches).


## Other things that need completing.

### Ansible playbook
I'd really like to be able to deploy an Arch image onto a real laptop or virtual
machine so as to maintain a consistent workspace.
This could then be used with packer to create a base arch box, which could then
be managed with vagrant.

### Shell utility to easily switch themes
Right now I'm loving solarized, but it'd be nice to be able to switch to another
theme if I wanted to do so.
This would involve having a list of configs detailing the parameters, and using
sed to inline replace the relevant fields and reload everything.
Or, have includes for a file which is a symlink to another small config.
This way we're only modifying symlinks.
One way would be to have a repo dedicated entirely to hosting and switching
between these themes.
