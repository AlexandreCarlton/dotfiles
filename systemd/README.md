# systemd user config files

Requires xorg-launch-helper from the AUR.

Currently the setup is this:
 - wm.target (aliased to default.target)
   - Wants bspwm and sxhkd
 - xorg.target (active as soon as Xorg is ready to accept incoming connections)
   - xorg.service launches before this
   - xinit.target requires this
 - xinit.target (essentially ~/.xinitrc)
   - Wants pretty much all programs that are normally started in ~/.xinitrc.


Pretty much all of these are ripped from the Arch Wiki; consult them for more information.

# Tips for better startup time.
If using an HDD (and running Arch), install `systemd-readahead` from the AUR, and run:
```sh
    # systemctl enable systemd-readahead-collect systemd-readahead-replay
```
Note that you will need to reboot a few times before the performance gains kick in.
SSDs may experience little to none (or potentially negative) increases in performance.
In my case, boot time increased on an HDD; perhaps this is due to my (rather limited) memory.
