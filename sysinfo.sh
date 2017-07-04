#!/bin/bash
# System Info Tool v1 - Mike Ladouceur
echo This simply copies your system information to the clipboard to paste in a chat room.
echo

SI="echo Hostname: $(hostname) \** OS: $(cat /etc/lsb-release | grep DESCRIPTION | cut -c 22- | head -c -2) \** CPU: $(cat /proc/cpuinfo | grep model | grep name | cut -c 14-) \** RAM: $(echo $(grep MemTotal /proc/meminfo | awk '{print $2}') / 1000000 | bc)GB \** VGA: $(lspci | grep VGA | awk '{$1=$2=$3=$4=""; print $0}') \** Uptime: $(uptime --pretty | cut -c 4-)"

if ! which xclip > /dev/null; then
    echo
    echo 'You'll need xclip for this to work.'
    echo
    exit 1
fi

if ! which bc > /dev/null; then
    echo
    echo 'You'll need bc for this to work.'
    echo
    exit 1
fi

if [[ $# -eq 0 ]] ; then
    echo $($SI) | xclip -selection clipboard
    exit 0
fi

case "$1" in
    -s) echo $($SI) ;;
    --shell) echo $($SI) ;;
    -?) echo Usage: sysinfo && echo      sysinfo -s [This pastes to the shell instead] && echo      system --shell [This pastes to the shell instead] ;;
    --help) echo Usage: sysinfo && echo      sysinfo -s [This pastes to the shell instead] && echo      system --shell [This pastes to the shell instead] ;;
    *) echo Try running this on its own or run: sysinfo --help ;;
esac
