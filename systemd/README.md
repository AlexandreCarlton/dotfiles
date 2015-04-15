# systemd user config files

## Make Xorg run with root privileges
```sh
$ cat /etc/X11/Xwrapper.config
allowed_users=anybody
needs_root_rights=yes
```

## Current setup
Targets are designed to
 - wm.target (aliased to default.target)
   - aliased to default.target, so this kicks off everything.
   - Wants bspwm and sxhkd
 - xorg.target (active as soon as Xorg is ready to accept incoming connections)
   - If you need something that requires Xorg to be launched, include After=xorg.target
   - xorg.service launches before this (See if you still need to specify this - maybe xorg.socket instead?)
   - xinit.target requires this
 - xinit.target (essentially ~/.xinitrc)
   - Wants pretty much all programs that are normally started in ~/.xinitrc.

Pretty much all of these are ripped from the Arch Wiki; consult them for more information.
Other sources include casucci, gtmanfred, KaiSforza and Zoqueski.

## After/Wants/Requires
To ensure everything is loaded in the right order, we place the services in order
of the targets they want (rephrase)
 - Wants means the dependency is optional
 - Requires means the dependency is NOT optional
 - After means the service is launched after the target/service in question. If only one of the above fields are used then the services will be launched in parallel.

## Tips for better startup time.
If using an HDD (and running Arch), install `systemd-readahead` from the AUR, and run:
```sh
    # systemctl enable systemd-readahead-collect systemd-readahead-replay
```
Note that you will need to reboot a few times before the performance gains kick in.
SSDs may experience little to none (or potentially negative) increases in performance.
In my case, boot time increased on an HDD; perhaps this is due to my (rather limited) memory.

# TODO
- Start tmux as a socket (if possible)
- Rename targets to be more descriptive
  - wm.target to window-manager.target
  - xorg.target to display-server.target (what about graphical?)
    - So when wayland can be used we can easily sub it out without any confusion.
