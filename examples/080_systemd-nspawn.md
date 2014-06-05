# Systemd-nspawn

## Demo

### Launch a Debian container

```
# Install a base Debian tree (this takes a while)
debootstrap --arch=amd64 unstable /srv/debian/

# Launch a Debian container
systemd-nspawn -D /srv/debian/
```

### Launch an Arch Linux container
```
# Install a base Arch Linux tree
pacstrap -c -d /srv/arch/ base

# Launch an Arch container, simulating boot
systemd-nspawn -bD /srv/arch/
```

## References:
 * www.freedesktop.org/software/systemd/man/systemd-nspawn.html