#!/bin/bash
# swapload v3
# /usr/local/sbin/rc.local

LOGFILE=/var/log/swapload.log
echo "================" >>${LOGFILE}
date >> ${LOGFILE}
echo "================" >>${LOGFILE}
function swapload {
sleep 15

SWAPLOADED=`swapon -s | wc -l`

if [ $SWAPLOADED -gt 1 ]; then
	echo "Swap already loaded" >> ${LOGFILE}
	swapon -s >> ${LOGFILE} 2>&1
	echo "Exiting!" >> ${LOGFILE}
	exit
fi

for DEVICE in `egrep "sd.1" /proc/partitions | grep -v sda | awk '{print $4}'` ; do
	echo "Trying to swapload device /dev/${DEVICE}" >> ${LOGFILE}
	swapon /dev/${DEVICE} >> ${LOGFILE} 2>&1
	if [ $? -eq 0 ]; then
		echo "Successfully swaploaded device /dev/${DEVICE}" >> ${LOGFILE}
		exit
	fi
done

# Get devices with free space greater than 1.5 GB and total size less than 65 GB
#!/bin/bash

{
df | grep "/media" | awk '{print $0}' | sed 's/  */ /g' | cut -d" " -f 2,6- | sort -n | cut -d" " -f 2-  | while read MP
do
	FILE_COUNT=`ls -1 "${MP}" | egrep -v -w "(lost\+found|swap|clone)" | wc -l`
	echo MP $MP FILE_COUNT $FILE_COUNT
	if [ $FILE_COUNT -eq 0 ] ; then
		if [ -d "${MP}"/swap ] && [ `ls -1 "${MP}"/swap | grep -v "lost+found" | wc -l` -eq 0 ] ; then
			echo "Going to make this drive my bitch - "${MP}"" | tee "${MP}"/will_swap.txt
			DEVICE=`df | grep -w "${MP}" | awk '{print $1}'| sed 's/[0-9]$//g'`
			echo "This device is going to be our slave - $DEVICE"
			
			umount ${DEVICE}*
			dd if=/dev/zero of=${DEVICE} bs=512 count=20 conv=notrunc
			echo -e "o\nn\np\n1\n\n+1G\nn\np\n\n\n\nw\n"|fdisk ${DEVICE}

			mkswap -L pogo_swap ${DEVICE}1 && swapon ${DEVICE}1
			/usr/bin/killall udevil
			/usr/bin/systemctl stop systemd-udevd
			mkfs.ext4 -F -L pogo_usb ${DEVICE}2 

			if [ ! -d /media/pogo_usb ]; then
				mkdir /media/pogo_usb
			fi
			mount ${DEVICE}2 /media/pogo_usb
			systemctl start systemd-udevd
			/usr/sbin/udevil --monitor & disown
			exit
		elif [ -d "${MP}"/clone ]; then
			# TODO: Code for cloning rootfs
			null
		fi
	fi
done
} >> ${LOGFILE} 2>&1

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

function start_all_transmission_downloads {
	sleep 30
	date >> /var/log/mystartup.log
	/usr/bin/transmission-remote -tall -s >> /var/log/mystartup.log 2 >&1 
}
echo "+++++++++++++++++++++++++++++++++++++++++++"
date >> /var/log/mystartup.log
echo "+++++++++++++++++++++++++++++++++++++++++++"
swapload &
start_all_transmission_downloads &

