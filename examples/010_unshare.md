# Kernel namespace examples

## Network namespace example

We'll start a simple HTTP server that will be totally isolated on the network.
No external or even internal processes will be able to access this service
over the network. Totally useless!

It is, of course, possible to control limited access of this process to
other network sockets or other containerized resources.  As a proof-of-concept,
plainly limiting all access should be, uh, demonstrative.

### Public/Isolated Webserver
```
# Launch a web server on port 8000
$: /bin/python -mSimpleHTTPServer &
Serving HTTP on 0.0.0.0 port 8000 ...

# Verify that the main system sees the process attached to port 8000
$: netstat -nlt | grep 8000
tcp        0      0 0.0.0.0:8000            0.0.0.0:*               LISTEN

# Clean up that webserver
$: kill %1

# Launch the webserver, within a network namespce
$: sudo unshare --net /bin/python -- -mSimpleHTTPServer &
# Verify that the process is not visible to the main OS
$: netstat -nlt | grep 8000
```

### Isolated bash session

Now we can launch a bash session within a network namespace:

```
sudo unshare --network /bin/bash
```

From here, we'll have no access to external network, or other resources
running on this host.  If you want to run any network processes, you'll
have to enable the loopback interface.

```
# Enable the loopback interface
$: ifconfig lo up
# Start a webserver
$: python -mSimpleHTTPServer &
# Connect to webserver from within the same namepace (other processes
# on the host will not be able to connect)
$: curl 127.0.0.1:8000
```

## UTS (hostname) namespace example

The UTS namespace is used to isolate some data structures representing
the host machine.  One practical example of this is the machine's hostname.

```
# Create a bash session with a UTS namespace
$: sudo unshare -u /bin/bash
# Within that bash session, set the hostname
$: hostname
# Elsewhere, sudo hostnamectl set-hostname Booyeah2
# won't affect the hostname that container sees
```

