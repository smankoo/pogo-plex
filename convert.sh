#!/bin/bash
# convert.sh

for file in ~/HandBrake/convert/*
do HandBrakeCLI -v -i "$file" -o "$file".converted.[FILE-EXTENSION-GOES-HERE] --preset [PRESET-NAME-GOES-HERE] ;

#uncomment next line to delete original
#rm $file

done