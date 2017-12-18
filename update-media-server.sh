#!/bin/sh
vidloc=/mnt/usb0/videos/TV/

for show in "svu" "theory" "family"
do
  file=$(find /home/mike/Downloads/ | grep -i $show | grep -i -v sample | grep -e mp4 -e mkv)
  season=$(echo $file | grep -i -o 's[0-9][0-9]' | cut -c 2-4 | head -n 1)
  dir=$vidloc/$(find $vidloc | grep -i $show | grep Season | sed -r 's/^.{20}//' | sed -e 's/\/.*E*//' | tail -1)

if [ -n "$file" ]; then
    mv $file "$dir/Season $season/"
    echo "Copying new episode of:" $(echo $file | sed -r 's/^.{21}//' | sed -e 's/.S.*E*//' | tr '.' ' ')
else
    echo .
fi

done
