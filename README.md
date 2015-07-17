# Alexandre's dotfiles
These are my config files for easy deployment on new machines.

```bash
    git clone git@github.com:AlexandreCarlton/dotfiles.git ~/.dotfiles
```
Ensure your previous dotfiles are backed up before installing these new ones.

## Installation of dotfiles
First pull in the third-party repositories (e.g. oh-my-zsh) and install GNU stow.
```bash
    pacman -S stow
    cd ~/.dotfiles
    make update
```
Use `make help` to see more options.

## Consistent theming
As you can probably tell, I'm a big fan of the [Solarized colour scheme](https://ethanschoover.com/solarized).
If you wish to change this, then the following files will need to be edited:
 - ~/.Xresources
 - ~/.gtkrc-2.0
 - ~/.config/gtk-3.0/settings.ini
 - ~/.spacemacs
 - ~/.vimrc
Fontwise, I'm using Gohufont and changing this requires editing all
the aforementioned files bar ~/.vimrc.
At some point I'll add this as a submodule to ~/.fonts.
Right now I'm not using Powerline fonts; they were too much trouble to get
working with URxvt (I had to install a second patched-font which was rather inelegant).
I'll consider using it in the future if PowerlineSymbols.otf doesn't mess with URxvt.

## Troubleshooting
This is for personal reference when I inevitably break something and can't easily fix it.
You'll need to boot into another run level (normally 3) by appending "1" (without quotations) to the kernel command line:
```
    kernel /vmlinz-llinux ... root=/dev/sda2 ro 1
```
Then you can revert any changes as root.
You can change the boot level by going into the Advanced options.
You can change user with `su - <username>` if necessary (e.g. switching git branches).

## Other things that need completing.
### Migration of dotfiles to a system-specific repository
You may find certain files that are not dotfiles; these are system-specific
and thus should not be here (e.g. connman resources or installation of dash in Makefile).
Eventually these will be migrated to a puppet/salt-stack repository to automate system set up.
We'd have modules which group certain things, like:
 - xorg configuration
 - games
 - programming (python, haskell)

### Shell utility to easily switch themes
Right now I'm loving solarized, but it'd be nice to be able to switch to another
theme if I wanted to do so.
This would involve having a list of configs detailing the parameters, and using
sed to inline replace the relevant fields and reload everything.
