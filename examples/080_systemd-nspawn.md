# Systemd-nspawn

## Demo

```
# Install a base debian tree (this takes a while)
debootstrap --arch=amd64 unstable /srv/debian/

# Launch a debian container
systemd-nspawn -D ~/debian-tree/

# Install a base Arch Linux tree
pacstrap -c -d /srv/arch-tree/ base

# Launch an Arch container
systemd-nspawn -bD /srv/arch-tree/
```

## References:
 * www.freedesktop.org/software/systemd/man/systemd-nspawn.html