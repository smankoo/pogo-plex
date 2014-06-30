#!/bin/bash
# monitor.sh
inotifywait --monitor -e moved_to -e create ~/HandBrake/convert | while read dir;
do
(~/HandBrake/convert.sh)

done