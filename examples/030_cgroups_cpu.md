# Cgroups
```
# Create cgroups AA and BB
mkdir /sys/fs/cgroup/cpu,cpuacct/AA
mkdir /sys/fs/cgroup/cpu,cpuacct/BB

# Give AA 100 'shares' and BB '200' shares
echo 100 > /sys/fs/cgroup/cpu,cpuacct/AA/cpu.shares
echo 200 > /sys/fs/cgroup/cpu,cpuacct/BB/cpu.shares

# Put this shell in AA cgroup
echo $$ | sudo tee /sys/fs/cgroup/cpu,cpuacct/AA/tasks

##
dd if=/dev/zero of=/dev/null
```