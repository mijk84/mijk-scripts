#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

mv /etc/lsb-release /etc/lsb-release.bak

cat > lsb-release <<EOL
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu Xenial Xerus"
EOL

mv ./lsb-release /etc/lsb-release

wget https://download.01.org/gfx/ubuntu/16.04/main/pool/main/i/intel-graphics-update-tool/intel-graphics-update-tool_2.0.2_amd64.deb

apt-get -y install ttf-ancient-fonts
yes | dpkg -i ./intel-graphics-update-tool_2.0.2_amd64.deb

intel-graphics-update-tool

rm /etc/lsb-release
mv /etc/lsb-release.bak /etc/lsb-release
