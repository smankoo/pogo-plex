#!/bin/bash

if [ "${1}" = "" ]; then
	echo "Filename not specified."
	exit 1
else
	ls -l /home/mankoo/handbrake-in/"${1}" > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "File does not exist : /home/mankoo/handbrake-in/${1}"
		exit
	else
		echo "Converting file : /home/mankoo/handbrake-in/${1}"
		NEW_NAME=`echo "${1}" | sed "s/.[^.]*$/.m4v/"`
		echo "New File : $NEW_NAME"
		nohup handbrakecli --preset "High Profile" -q 21.0 --optimize -i /home/mankoo/handbrake-in/"${1}" -o /home/mankoo/handbrake-out/"${NEW_NAME}" &
	fi
fi
