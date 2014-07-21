#!/bin/bash
date
echo transmission-start.sh
BIN=/usr/bin/transmission-remote

USER=transmission
PASS=Gaurav@123

$BIN -n $USER:$PASS -l | awk -v bin="$BIN" -v auth="$USER:$PASS" '$10 ~ /Finished/ || $10 ~ /Seeding/ || $10 ~ /Done/ || $2 ~ /100/ { print bin" -n "auth" -t "$1" -r\0" }' | xargs -0 -I{} bash -c {}

$BIN -n $USER:$PASS -tall --start
