#!/bin/sh
release=$(lsb_release -cs)
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | apt-key add -
wget -O- http://archive.getdeb.net/getdeb-archive.key | apt-key add -
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7

mv /etc/apt/sources.list /etc/apt/sources.list.old
cat << EOF | tee /etc/apt/sources.list
#------------------------------------------------------------------------------#
#                            OFFICIAL UBUNTU REPOS                             #
#------------------------------------------------------------------------------#

###### Ubuntu Main Repos
deb http://ca.archive.ubuntu.com/ubuntu/ $release main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ $release main restricted universe multiverse

###### Ubuntu Update Repos
deb http://ca.archive.ubuntu.com/ubuntu/ $release-security main restricted universe multiverse
deb http://ca.archive.ubuntu.com/ubuntu/ $release-updates main restricted universe multiverse
deb http://ca.archive.ubuntu.com/ubuntu/ $release-proposed main restricted universe multiverse
deb http://ca.archive.ubuntu.com/ubuntu/ $release-backports main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ $release-security main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ $release-updates main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ $release-proposed main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ $release-backports main restricted universe multiverse

###### Ubuntu Partner Repo
deb http://archive.canonical.com/ubuntu $release partner
deb-src http://archive.canonical.com/ubuntu $release partner

###### Ubuntu Extras Repo
deb http://extras.ubuntu.com/ubuntu $release main
deb-src http://extras.ubuntu.com/ubuntu $release main

#------------------------------------------------------------------------------#
#                           UNOFFICIAL UBUNTU REPOS                            #
#------------------------------------------------------------------------------#

###### 3rd Party Binary Repos

#### GetDeb - http://www.getdeb.net
## Run this command: wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
deb http://archive.getdeb.net/ubuntu $release-getdeb apps

#### PlayDeb - http://www.playdeb.net/
## Run this command: wget -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
deb http://archive.getdeb.net/ubuntu $release-getdeb games

#### WebUpd8 PPA - http://www.webupd8.org/
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
deb http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu $release main

#### Wine PPA - https://launchpad.net/~ubuntu-wine/+archive/ppa/
## Run this command:  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
deb http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu $release main

####### 3rd Party Source Repos

#### WebUpd8 PPA (Source) - http://www.webupd8.org/
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
deb-src http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu $release main

#### Wine PPA (Source) - https://launchpad.net/~ubuntu-wine/+archive/ppa/
## Run this command:  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
deb-src http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu $release main
EOF

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
