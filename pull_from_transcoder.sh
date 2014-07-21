#!/bin/bash

if [ "$1" != "" ]; then
scp mankoo@192.168.0.122:/home/mankoo/handbrake-out/"$1" /media/pogo_hd1/movies/
else
echo "No file specified"
fi

