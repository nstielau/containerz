# Cgroups CPU Examples


Shell 1:
```
# Create cgroups AA
$: mkdir /sys/fs/cgroup/cpu,cpuacct/AA

# Give AA 100 'shares'
$: echo 100 > /sys/fs/cgroup/cpu,cpuacct/AA/cpu.shares

# Put this shell in AA cgroup
$: echo $$ | sudo tee /sys/fs/cgroup/cpu,cpuacct/AA/tasks

# Run a CPU intenstive operation
$: dd if=/dev/zero of=/dev/null

```

Shell 2
```
# Create cgroups BB
$: mkdir /sys/fs/cgroup/cpu,cpuacct/BB

# Give BB '200' shares
$: echo 200 > /sys/fs/cgroup/cpu,cpuacct/BB/cpu.shares

# Put this shell in BB cgroup
$: echo $$ | sudo tee /sys/fs/cgroup/cpu,cpuacct/BB/tasks

# Run a CPU intenstive operation
$: dd if=/dev/zero of=/dev/null &

# Run 'top' and you'll see the process in the AA cgroup
# using roughly one half of the CPU that the processs in the BB
# group is using.
$: top
```

