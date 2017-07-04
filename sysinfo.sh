#!/bin/sh
# System Info Tool v1 - Mike Ladouceur
echo This simply copies your system information to the clipboard to paste in a chat room.
echo

if ! which xclip > /dev/null; then
	echo "You will need to install xclip for this to work..."
	else echo Hostname: $(hostname) \** OS: $(cat /etc/lsb-release | grep DESCRIPTION | cut -c 22- | head -c -2) \** CPU: $(cat /proc/cpuinfo | grep model | grep name | cut -c 14-) \** RAM: $(echo $(grep MemTotal /proc/meminfo | awk '{print $2}') / 1000000 | bc)GB \** VGA: $(lspci | grep VGA | awk '{$1=$2=$3=$4=""; print $0}') \** Uptime: $(uptime --pretty | cut -c 4-) | xclip -selection clipboard
fi
