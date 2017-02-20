#!/bin/sh
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | apt-key add -
wget -O- http://archive.getdeb.net/getdeb-archive.key | apt-key add -
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0

mv /etc/apt/sources.list /etc/apt/sources.list.old
cat << EOF | tee /etc/apt/sources.list
#------------------------------------------------------------------------------#
#                            OFFICIAL UBUNTU REPOS                             #
#------------------------------------------------------------------------------#

###### Ubuntu Main Repos
deb http://ca.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse

###### Ubuntu Update Repos
deb http://ca.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://ca.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://ca.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://ca.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse

###### Ubuntu Partner Repo
deb http://archive.canonical.com/ubuntu trusty partner
deb-src http://archive.canonical.com/ubuntu trusty partner

###### Ubuntu Extras Repo
deb http://extras.ubuntu.com/ubuntu trusty main
deb-src http://extras.ubuntu.com/ubuntu trusty main

#------------------------------------------------------------------------------#
#                           UNOFFICIAL UBUNTU REPOS                            #
#------------------------------------------------------------------------------#

###### 3rd Party Binary Repos

#### GetDeb - http://www.getdeb.net
## Run this command: wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
deb http://archive.getdeb.net/ubuntu trusty-getdeb apps

#### PlayDeb - http://www.playdeb.net/
## Run this command: wget -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
deb http://archive.getdeb.net/ubuntu trusty-getdeb games

#### WebUpd8 PPA - http://www.webupd8.org/
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
deb http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu trusty main

#### Wine PPA - https://launchpad.net/~ubuntu-wine/+archive/ppa/
## Run this command:  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
deb http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu trusty main

####### 3rd Party Source Repos

#### WebUpd8 PPA (Source) - http://www.webupd8.org/
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C9D234C
deb-src http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu trusty main

#### Wine PPA (Source) - https://launchpad.net/~ubuntu-wine/+archive/ppa/
## Run this command:  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9CB8DB0
deb-src http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu trusty main
EOF
#### WebUpd8 Java
add-apt-repository -y ppa:webupd8team/java

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
