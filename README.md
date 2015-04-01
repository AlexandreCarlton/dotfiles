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

## Troubleshooting
This is for personal reference when I inevitably break something and can't easily fix it.
You'll need to boot into another run level (normally 3) by appending "1" (without quotations) to the kernel command line:
```
    kernel /vmlinz-llinux ... root=/dev/sda2 ro 1
```
Then you can revert any changes as root.
You can change the boot level by going into the Advanced options.
