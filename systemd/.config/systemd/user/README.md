# systemd user config files

## Make Xorg run with root privileges
Edit the relevant config file:
```sh
$ cat /etc/X11/Xwrapper.config
allowed_users=anybody
needs_root_rights=yes
```

## Set the default DISPLAY
This variable is used by any X application wanting to know which display to use:
```sh
$ cat /etc/systemd/user.conf
...
DefaultEnvironment=DISPLAY=:0
...
```

## Current setup
Targets are designed to group up logical units to allow easier dependency tracking.
The three main targets here are:
 - desktop.target
   - aliased to default.target when enabled, so this kicks off everything.
   - groups up everything needed to set up a working, graphical desktop.
   - Generally, a service should have "WantedBy=desktop.target", unless it is a special unit.
   - Requires display-server.target and wants window-manager.service.
 - display-server.target (active as soon as Xorg is ready to accept incoming connections)
   - active as soon as the server is ready to accept connections
   - if you need the server up for a service, include "After=display-server.target"
   - If enabled, xorg.socket is launched before this; so this will be ready
     only if xorg.socket is. Note that if not enabled, "Before=" in xorg.socket
     won't do anything.
 - window-manager.service
   - An alias for a given window manager service (e.g. bspwm.service).
   - Having an alias means only one window-manager may be active (I think).
   - Window managers must have "Alias=window-manager.service".

sockets.target is also used to launch all sockets (which launch the
respective service files on incoming connections).
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
- Start weston-launcher as a service to be swapped in for xorg.
- Reintroduce xorg.target to group up services like xset.
  - instead of wanting xorg.socket, we want xorg.target
  - this target is required by display-server.target.
- Use 8-bit day wallpapers
    - Change wallpaper to reflect time.
    - Requires timers and services - 1 for initial startup, and others for each time.
