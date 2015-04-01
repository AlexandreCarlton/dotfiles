# Template configs for Connman

Remember to add a Passphrase field (obviously not included)

Still can't get UniSydney to work.

# Switching back to NetworkManager
If Connman fails for whatever reason, boot up NetworkManager:
```sh
$ sudo systemctl stop connman
$ sudo systemctl start NetworkManager
$ nm-applet &
```
UniSydney refuses to connect if I don't have nm-applet enabled. Go figure.
It's worth pointing out that NetworkManager is slow (both at starting up and resolving connections), and hence is rarely used.
