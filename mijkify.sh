#!/bin/sh
release=$(lsb_release -cs)
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7

#### WebUpd8 Java
yes | add-apt-repository -y ppa:webupd8team/java

## Google Chrome
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

## Steam
sh -c 'echo "deb http://repo.steampowered.com/steam/ precise steam" >> /etc/apt/sources.list.d/steam.list'

## Minecraft
yes | add-apt-repository ppa:minecraft-installer-peeps/minecraft-installer

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install -y build-essential cmake qt5-qmake flex bison git subversion mercurial oracle-java8-installer google-chrome-stable steam minecraft-installer quassel-client transgui
