#!/bin/bash
# delete_sample.sh

echo "delete_sample.sh: running script on dir /media/pogo_hd1/downloads" >> /var/log/pogo-plex.log
echo "Removing following files" >> /var/log/pogo-plex.log
find /media/pogo_hd1/downloads -iname "*sample*.???" -type f -exec echo {} \; >> /var/log/pogo-plex.log
find /media/pogo_hd1/downloads -iname "*sample*.???" -type f -exec rm {} \; >> /var/log/pogo-plex.log



