#!/bin/bash

umount /dev/sdb*  2>/dev/null
swapoff /dev/sdb1
for v_partition in $(parted -s /dev/sdb print|awk '/^ / {print $1}')
do
   parted -s /dev/sdb rm ${v_partition}
done

dd if=/dev/zero of=/dev/sdb bs=512 count=2052 conv=notrunc

# Find size of disk
v_disk=$(parted -s /dev/sdb print|awk '/^Disk/ {print $3}'|sed 's/[Mm][Bb]//')

# Create single partition
parted -s /dev/sdb mkpart primary 0 ${v_disk}

# Format the partition
mkfs.ext4 -F /dev/sdb1

# Mount new partition
#mount /dev/sdb1 /media/raw_usb
