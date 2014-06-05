# cgtools Examples
Cgroups tools are helpers for creating and managing cgroups.  It's a little
more friendly than using `mkdir` and `echo` (but still pretty low level).

You may need to `yum install libcgroups-tools` or the equivilent.


```
# Create cgroups A and B
sudo cgcreate -g cpu:A
sudo cgcreate -g cpu:B

# Get the cpu.shares setting
cgget -r cpu.shares A
cgget -r cpu.shares B

# Run a cpu intensive task in each cgroup (in the backgorund).
# (dd is a tool for copying bytes on disk. This is just copying
# dummy data to a dummy location, burning CPU)
sudo cgexec -g cpu:A dd if=/dev/zero of=/dev/null &
sudo cgexec -g cpu:B dd if=/dev/zero of=/dev/null &

# Run 'top' to see roughly equal CPU usage
top

# Kill those backgrounded jobs
kill %1; kill %2; jobs

# Update the cpu.shares setting to give A 3x more than B
# The values for cpu.shares are arbitrary and relative to
# one another.
sudo cgset -r cpu.shares=768 A
sudo cgset -r cpu.shares=256 B

# Repeat the CPU intensive task
sudo cgexec -g cpu:A dd if=/dev/zero of=/dev/null &
sudo cgexec -g cpu:B dd if=/dev/zero of=/dev/null &

# Run 'top' to see roughly 3x CPU usage
top

# Kill those backgrounded jobs
kill %1; kill %2; jobs
```

## References

* http://oakbytes.wordpress.com/2012/09/02/cgroup-cpu-allocation-cpu-shares-examples/