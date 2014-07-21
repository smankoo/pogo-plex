#!/bin/bash

if [ "$1" != "" ]; then
scp "$1" mankoo@192.168.0.122:/home/mankoo/handbrake-in
else
echo "No file specified"
fi

