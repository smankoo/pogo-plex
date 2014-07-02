#!/bin/bash
# rootfs_backup.sh

df | grep /media/pogo_hd1 > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "====================================================" >> /var/log/rootfs_backup.log
	echo "Starting rootfs backup at : " `date '+%d/%m/%Y %H:%M:%S'` >> /var/log/rootfs_backup.log
	echo "====================================================" >> /var/log/rootfs_backup.log

	rsync -av --delete-excluded --exclude-from=/root/scripts/backup.lst / /media/pogo_hd1/others/pogo_os/pogo_os
	cd /media/pogo_hd1/others/pogo_os/pogo_os
	NUM_DATE=`date '+%Y%m%d%H%M%S'`
	/usr/bin/tar -zcvf /media/pogo_hd1/others/pogo_os/pogo_os.${NUM_DATE}.tar.gz *
	if [ $? -eq 0 ]; then
		if [ -f /media/pogo_hd1/others/pogo_os/pogo_os.${NUM_DATE}.tar.gz ]; then
			df | grep /media/yandex >dev/null 2>&1
			if [ $? -eq 0 ]; then
				if [ ! -d /media/yandex/pogo-plex/pogo_os ]; then
					mkdir -p /media/yandex/pogo-plex/pogo_os
				fi
				rsync -av --delete-excluded --exclude-from=/root/scripts/backup.lst /media/pogo_hd1/others/pogo_os/pogo_os /media/pogo_hd1/others/pogo_os/pogo_os
				#cp /media/pogo_hd1/others/pogo_os/pogo_os.${NUM_DATE}.tar.gz /media/yandex/pogo-plex
			fi
		fi
	fi
fi
