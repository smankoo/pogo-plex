#!/bin/bash
# put swap on

LOGFILE=/var/log/swapload.log
echo "================" >>${LOGFILE}
date >> ${LOGFILE}
echo "================" >>${LOGFILE}
function swapload {
sleep 30

for DEVICE in `egrep "sd.1" /proc/partitions | grep -v sda | awk '{print $4}'` ; do
	echo "Trying to swapload device /dev/${DEVICE}" >> ${LOGFILE}
	swapon /dev/${DEVICE} >> ${LOGFILE} 2>&1
	if [ $? -eq 0 ]; then
		echo "Successfully swaploaded device /dev/${DEVICE}" >> ${LOGFILE}
		exit
	fi
done

# Get all devices that have available space greater than 1.5 GB
# in the increasing order of their total size (therefore prioritizing
# smaller drivers i.e. usb sticks)
for DEVICE in `df | grep "/media" | awk '$4 > 1572864 {print $2" "$6}' | sort -n | awk '{print $2}'`; do
	if [ -f ${DEVICE}/system/swapfile.img ]; then
		swapon ${DEVICE}/system/swapfile.img
		echo `date` swapon ${DEVICE}/system/swapfile.img >> ${LOGFILE}
		exit
	else
		# check if drive is mounted
		df | grep -w ${DEVICE} >/dev/null 2>&1
		if [ $? -eq 0 ]; then
			if [ ! -d ${DEVICE}/system ]; then
				mkdir ${DEVICE}/system
			fi
			dd if=/dev/zero of=${DEVICE}/system/swapfile.img bs=1M count=1024 && mkswap ${DEVICE}/system/swapfile.img && swapon ${DEVICE}/system/swapfile.img && echo swap file created ${DEVICE}/system/swapfile.img && exit
		fi
	fi
done

}

swapload &
