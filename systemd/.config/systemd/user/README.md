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
Our setup includes:

- a `bspwm-session.target` that `BindsTo=graphical-session.target`.
  The latter is a special unit that is active whenever any graphical session is
  running, and is ready once all of its dependent units are active.
  In this case, `bspwm-session.target` fires up the main services needed to
  start a bspwm session so they do not need to be enabled individually.

- Units that require a graphical session up and running should have:
  - `PartOf=graphical-session.target` so that stopping and restarting
    `graphical-session.target` brings down these services too.
  - `Requires=graphical-session-pre.target` and
  - `After=graphical-session-pre.target` so that we may guarantee we have
    everything we need to start up the session.
  Note that `graphical-session-pre.target` is responsible for loading all the
  services necessary to start a session, but for some reason is not
  automatically enabled (hence the `Requires=`).

- `graphical-session-pre.target` would preferably have consisted of setting up
  `x11.socket`, but unfortunately we need to start up `xorg` eagerly to prevent
  clients from deadlocking.
  We thus have `xorg-delay@` service to fire up `xorg` before
  `graphical-session-pre.target` is ready.

 - Units that require a `graphical-session` but are independent of the session
   (e.g. `dunst`, `redshift`) should also have
   `WantedBy=graphical-session.target`, so that they may be restarted/stopped
   with the graphical session.

`sockets.target` is also used to launch all sockets (which launch the
respective service files on incoming connections).
Enabling sockets cost us practically nothing, and so should be pretty much
always enabled.

## After/Wants/Requires
To ensure everything is loaded in the right order, we place the services in order
of the targets they want:
 - `Wants` means the dependency is optional - if the dependency fails, the service will continue.
 - `Requires` means the dependency is essential - if the dependency fails, so will this.
 - `After` means the service is launched after the target/service in question.
   If only one of the above fields are used then the services will be launched in parallel.

## Tips for better startup time.
If using an HDD (and running Arch), install `systemd-readahead` from the AUR, and run:
```sh
    # systemctl enable systemd-readahead-collect systemd-readahead-replay
```
Note that you will need to reboot a few times before the performance gains kick in.
SSDs may experience little to none (or potentially negative) increases in performance.
In my case, boot time increased on an HDD; perhaps this is due to my (rather limited) memory.

# TODO
- See if Chromium can be launched in the background to increase startup time.
- Start weston-launcher as a service to be swapped in for xorg.
- Use 8-bit day wallpapers
    - Change wallpaper to reflect time.
    -z Requires timers and services - 1 for initial startup, and others for each time.
