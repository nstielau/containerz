# blockio Examples

The blockio cgroups tree is used to control block input/output rates such
as writing to disk.  SSDs can read and write from random locations on disk,
whereas spinning disks require 10s of milliseconds to 'seek' to the correct
location on disk to begin reading.  Limiting input/output rates is applicable
to all disks, but especially on spinning disks where one processes disk activity
can impact other processes.

## References
* http://cdn.oreillystatic.com/en/assets/1/event/61/Resource%20Allocation%20for%20Linux%20with%20Cgroups%20Presentation.pdf