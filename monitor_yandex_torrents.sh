#!/bin/bash
# monitor_yandex_torrents.sh

df | grep /media/pogo_hd1 > /dev/null 2>&1
if [ $? -eq 0 ]; then
	df | grep /media/yandex > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		/usr/bin/find /media/yandex/pogo-plex/torrents -iname "*.torrent" -exec mv {} /media/pogo_hd1/others/incoming-torrents \; >> /var/log/pogo-plex.log 2>&1
	fi
fi

