#!/bin/bash
# put swap on

LOGFILE=/tmp/swapload.log

function swapload {
sleep 30

for DEVICE in `egrep "sd.1" /proc/partitions | grep -v sda | awk '{print $4}'` ; do
	echo "Trying to swapload device $DEVICE" >> ${LOGFILE}
	swapon /dev/${DEVICE} >> ${LOGFILE} 2>&1
	if [ $? -eq 0 ]; then
		echo "Successfully swaploaded device $DEVICE" >> ${LOGFILE}
		exit
	fi
done

if [ -f /media/pogo_usb1/system/swapfile.img ]; then
	swapon /media/pogo_usb1/system/swapfile.img
	echo `date` swapon /media/pogo_usb1/system/swapfile.img >> ${LOGFILE}
	exit
elif [ -f /media/pogo_usb2/system/swapfile.img ]; then
	swapon /media/pogo_usb2/system/swapfile.img
	echo `date` swapon /media/pogo_usb2/system/swapfile.img >> ${LOGFILE}
	exit
elif [ -f /media/pogo_hd1/system/swapfile.img ]; then
	swapon /media/pogo_hd1/system/swapfile.img
	echo `date` swapon /media/pogo_hd1/system/swapfile.img >> ${LOGFILE}
	exit
elif [ -f /media/pogo_hd2/system/swapfile.img ]; then
	swapon /media/pogo_hd2/system/swapfile.img
	echo `date` swapon /media/pogo_hd2/system/swapfile.img >> ${LOGFILE}
	exit
fi
}

swapload &
