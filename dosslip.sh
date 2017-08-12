#!/bin/bash
# DOSBox Slip Setter - 2017 Mike Ladouceur
# Fork of Naszvadi Peter's "dosbox slip setter"

# Changes:
# - Downloads entire mTCP suite from Michael Brutman
# - Does not auto-launch IRCjr
# - Does not give you a random IRCjr username
# - Does not auto-exit
# - Does not delete everything once it's done
# - Fully usable DOSBox conf file (built into script!)

flushipt() {
  for i in $( iptables -t nat -n --line-numbers -L | awk '/^Chain POSTROUTING/,/^$/{print $0}' \
            | grep '^[0-9]' | grep '192\.168\.7\.' | awk '{ print $1 }' | tac )
  do
    iptables -t nat -D POSTROUTING "$i"
  done

  for i in $( iptables -t nat -n --line-numbers -L | awk '/^Chain PREROUTING/,/^$/{print $0}' \
            | grep ^[0-9] | grep '192\.168\.7\.' | awk '{ print $1 }' | tac )
  do
    iptables -t nat -D PREROUTING "$i"
  done
}

if id -u | grep -q '^0'; then
    :
else
    echo 'DOSBox Slip Setter'
    echo 'Author: Naszvadi Peter (fork by Mike Ladouceur)'
    echo
    echo "Please run $0 as root!"
    echo
    exit 1
fi

Uid="$(find "$0" -printf '%U' -quit)"

flushipt

Dev_Pts='/tmp/slip'"$RANDOM"
Slip_Port=8040

socat PTY,link="$Dev_Pts",raw,echo=0 TCP-LISTEN:"$Slip_Port" &
Pid_Saved_3="$!"
sleep 1

if [ -z "$(find . -iname ethersl.com)" ]; then
    mkdir -p ./mnt/net
    wget -q http://crynwr.com/drivers/pktd11.zip
    unzip -Cj pktd11.zip ethersl.com -d ./mnt/net && rm pktd11.zip
fi

if [ -z "$(find . -iname ircjr.exe)" ]; then
    wget -q http://www.brutman.com/mTCP/mTCP_2015-07-05.zip
    unzip mTCP_2015-07-05.zip -d ./mnt/net
fi

sudo -u "#$Uid" dosbox -conf dosslip.cnf &
Pid_Saved="$!"

# setting linux ipv4 forwarding
grep -q 1 /proc/sys/net/ipv4/ip_forward || ( echo 1 1>/proc/sys/net/ipv4/ip_forward )

slattach -d -s 115200 -p adaptive "$Dev_Pts" 1>/dev/null 2>/dev/null &
Pid_Saved_2="$!"

sleep 3

ifconfig sl0 192.168.7.1 dstaddr 192.168.7.2 netmask 255.255.255.252 mtu 576 up 1>/dev/null 2>/dev/null
set -x
iptables -t nat -A POSTROUTING -s 192.168.7.0/30 -j MASQUERADE 1>/dev/null 2>/dev/null
