#!/bin/bash

echo "======================================="
echo "Finding and killing all rsync processes"
echo "======================================="
date
echo "======================================="

ps -ef | grep rsync

/usr/bin/killall rsync
sleep 2
/usr/bin/killall rsync
sleep 2
/usr/bin/killall rsync
sleep 2
/usr/bin/killall rsync
sleep 2
/usr/bin/killall rsync

ps -ef | grep rsync

echo "======================================="
