#!/bin/bash
# delete_sample.sh

if [ "$TR_TORRENT_DIR" != "" ]; then
	find "$TR_TORRENT_DIR" -iname "*sample*" -exec rm {} \;
fi
