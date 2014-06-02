# Memory cgroups

## Demo

Set up a memory cgroup, and watch it kill a memory intensive process
```
# Create a cgroup called MyMemoryCgroup
mkdir /sys/fs/cgroup/memory/MyMemoryCgroup
# Limit at roughly 100MB
echo 100000000 > /cgroup/MyMemoryCgroup/memory.limit_in_bytes
# Add your shell to the memory group
echo $$ | sudo tee /sys/fs/cgroup/memory/MyMemoryCgroup/tasks
# Consume memory, until the process gets killed
./eat_memory
```

Here is the C code to eat up memory:
```
# Compile with: gcc ./eat_memory.c -o eat_memory
#include <stdlib.h>
#include <stdio.h>

int main()
{
  int total = 0;
  while(1)
  {
    malloc(1024*1024);
    total = total + 1;
    printf("Allocated %d MB\n", total);
  }
  return 0;
}
```

## References
* More at http://blog.dotcloud.com/kernel-secrets-from-the-paas-garage-part-24-c