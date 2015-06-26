# systemd user config files

## Make Xorg run with root privileges
Edit the relevant config file:
```sh
$ cat /etc/X11/Xwrapper.config
allowed_users=anybody
needs_root_rights=yes
```

## Current setup
Targets are designed to group up logical units to allow easier dependency tracking.
The three main targets here are:
 - desktop.target
   - aliased to default.target when enabled, so this kicks off everything.
   - groups up everything needed to set up a working, graphical desktop.
   - Generally, a service should have "WantedBy=desktop.target", unless it is a special unit.
   - Requires both window-manager.target and a display-server.target.
 - display-server.target (active as soon as Xorg is ready to accept incoming connections)
   - active as soon as the server is ready to accept connections
   - if you need the server up for a service, include "After=display-server.target"
   - If enabled, xorg.socket is launched before this; so this will be ready
     only if xorg.socket is. Note that if not enabled, "Before=" in xorg.socket
     won't do anything.
 - window-manager.target
   - Window managers must have "WantedBy=window-manager.target".

sockets.target is also used to launch all sockets (which implicitly launch the
respective service files).
This was largely based on the Arch Wiki; consult them for more information.
Other sources include casucci, gtmanfred, KaiSforza and Zoqueski.

## After/Wants/Requires
To ensure everything is loaded in the right order, we place the services in order
of the targets they want (rephrase)
 - "Wants" means the dependency is optional - if the dependency fails, the service will continue.
 - "Requires" means the dependency is essential - if the dependency fails, so will this.
 - "After" means the service is launched after the target/service in question. If only one of the above fields are used then the services will be launched in parallel.

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
  - Poettering has a nice blog post on why sockets are great.
- Rename targets to be more descriptive
  - wm.target to window-manager.target
  - xorg.target to display-server.target
    - then we enable xorg.socket or (potentially in future) wayland.service. (have them conflict with the other?)
    - Should make xset.service etc. have Wants=xorg.socket - wayland wouldn't need them, for example.
  - Maybe remove xinit.target? Nah, it's separate to xorg itself, but dependent on it.
  - xinit.target should be needed by xorg.socket? that way if we switch to wayland we won't launch these x services.
- Be more specific with targets
  - Specify what the service is wanted by; instead of 'default.target'
  - Note that user sessions don't respond to 'multi-user' or 'graphical' (that's for booting) - just default.
  - we could switch out wm.target for de.target (desktop environment like gnome)
  - don't have "Wants" in wm.target for services; but rather WantedBy in bspwm.service ; easy to enable and disable services. "Wants" for other targets is fine.
- Change wallpaper.service to allow the filename: wallpaper@PikachuEevee,service (or similar)
- Use 8-bit day wallpapers
    - Change wallpaper to reflect time.
    - Requires timers and services - 1 for initial startup, and others for each time.
