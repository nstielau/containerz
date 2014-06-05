# Memory cgroups

The memory cgroups tree is used to controll the ammount of memory
a given process will use.  There are options to configure resident
memory usage, swap, etc.

## Demo

### Reduce shell's memory to near nothing

Here, we'll set up a memory cgroup, and associate the current
shell with that cgroup.  We'll make the memory so low that the
shell will by killed as soon as any command is run.
```
# Create a cgroup called MyMemoryCgroup
mkdir /sys/fs/cgroup/memory/MyMemoryCgroup
# Limit at roughly 10 bytes
echo 10 > /cgroup/MyMemoryCgroup/memory.limit_in_bytes
# Add your shell to the memory group
echo $$ > /sys/fs/cgroup/memory/MyMemoryCgroup/tasks
# Run any command, which will require more memory than the
# shell is allowed.  The kernel will then kill the shell process.
./ls
Killed
```

### Use a program to aggresively allocate memory

This is similar to the example above, exceot that we'll write a
short C program to aggresively allocate memory.  The end result is
same as the example above, although it uses up more memory.  This
represents a more real-world use-case, where a process would be
limited to megabytes of memory rather than mere bytes.

```
# Create a cgroup called MyMemoryCgroup
mkdir /sys/fs/cgroup/memory/MyMemoryCgroup
# Limit at roughly 100MB
echo 100000000 > /cgroup/MyMemoryCgroup/memory.limit_in_bytes
# Add your shell to the memory group
echo $$ > /sys/fs/cgroup/memory/MyMemoryCgroup/tasks
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