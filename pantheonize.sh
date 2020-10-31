#!/bin/sh
if [ “$(id -u)” != “0” ]; then
   echo "This script must be run as root"
   exit 1
fi

cp /etc/lsb_release /etc/lsb_release.bak

echo Pantheonize v0.0.2 by mijk
echo.
echo This script will add the necessary PPA's to install the Pantheon window manager.
echo You must ensure to have install X and a display manager beforehand.
echo.
echo The installation will download approximately 1GB of data.
echo.
        # Adding the Elementary OS PPA's
        add-apt-repository -y ppa:elementary-os/daily
        add-apt-repository -y ppa:elementary-os/os-patches
        add-apt-repository -y ppa:elementary-os/testing

                # Upgrade the OS because there are likely updates to your installation on this PPA.
                # This will download about 250MB on average.
                apt-get update
                apt-get upgrade -y
                apt-get dist-upgrade -y

        # Time to install the packages, a good 750MB download here alone.
        apt-get install -y elementary-theme elementary-icon-theme elementary-default-settings elementary-desktop gtk2-engines-pixbuf gnome-themes-standard libcanberra-gtk3-module

         rm /etc/lsb_release
         mv /etc/lsb_release.bak /etc/lsb_release

        echo Done! Enjoy!
