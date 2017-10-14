#!/bin/sh
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

video=$(echo "$1" | sed -r 's/^.{32}//' | cut -f1 -d"&")

youtube-dl --prefer-insecure -o - "$video" -f 17 | mplayer -
