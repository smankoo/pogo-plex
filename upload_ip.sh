#!/bin/bash
# upload_ip.sh

{
echo "HUMAN_READABLE_DATE=`date '+%d/%m/%Y %H:%M:%S'`"
echo "NUMERIC_DATE=`date '+%Y%m%d%H%M%S'`"
IP_ADDR=`curl -L icanhazip.com`
echo "IP_ADDR=${IP_ADDR}"
echo 
} | tee /root/scripts/ip.txt 2>&1

df | grep /media/yandex >/dev/null 2>&1
if [ $? -eq 0 ]; then
	cp /root/scripts/ip.txt /media/yandex/pogo-plex/ip.txt
else
	mount /media/yandex
	if [ $? -eq 0 ]; then
		cp /root/scripts/ip.txt /media/yandex/pogo-plex/ip.txt
	fi
fi

#/usr/bin/google docs delete --title "pogo-plex-ip.txt" --yes
#/usr/bin/google docs upload /root/scripts/ip.txt --title "pogo-plex-ip.txt"


