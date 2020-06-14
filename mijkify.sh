#!/bin/sh
cli=build-essential cmake qt5-qmake flex bison git subversion mercurial autotools-dev autoconf google-chrome-stable
gui=google-chrome-stable steam quassel-client transgui

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

case "$1" in
'cli')
apt-get install -y $cli
;;
'gui')
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7

## Google Chrome
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

## Steam
sh -c 'echo "deb http://repo.steampowered.com/steam/ precise steam" >> /etc/apt/sources.list.d/steam.list'
apt-get install -y $cli $gui
;;
'')
echo "Usage: $0 [cli|gui]"
;;
esac
