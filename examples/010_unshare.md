# Network namespace:

Start a simple HTTP server that will be totally isolated on the network.
No external or even internal processes will be able to access this service
over the network.

```
sudo unshare --network /bin/bash
```

```
ifconfig lo up
python -mSimpleHTTPServer &
curl 127.0.0.1:8000 # This won't work anywhere outside of this server.
```

Or, as a one-liner

```
sudo unshare --net /bin/python -- -mSimpleHTTPServer
```

## Hostname namespace
sudo unshare -u /bin/bash
```
hostname
# Elsewhere, sudo hostnamectl set-hostname Booyeah2
# won't affect the hostname that container sees
```

