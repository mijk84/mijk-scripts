#! /bin/bash

# xwp-install-81-20-deb.sh
# A script to install WordPerfect 8.1 for Linux 
# on debian-based systems.
# \(c\) Peter Stone, 2020
# peter@xwp8users.com

echo " "
echo This script is designed to install WordPerfect 8.1 for Linux
echo on a debian-based distro current in 2020 or later. 
echo " " 
echo It has been tested on Mint 20, a 64-bit distro, 
echo and on the 32-bit version of MX 19.2.
echo " " 
echo Before running this script, you should have taken the following
echo preliminary steps:
echo " "
echo 1. Create the following directory, which will serve as
echo the working directory for the script: 
echo "   " ~/Downloads/wp81inst
echo " "
echo 2. Copy this script file to that directory.
echo
echo 3. Copy your wp8-full and fonts-x deb files from your 
echo Corel Linux cd to that directory.
echo " "
echo The script should be run as a normal user. It will call
echo for your sudo password on the first occasion that sudo
echo is called. 
echo " "
echo After changing to the working directory, the script can be 
echo executed with the command: 
echo "   " sh ./xwp-install-81-20-deb.sh

echo " "
echo Ensuring that the working directory exists.
test -e ~/Downloads/wp81inst
if ! [ $? = 0 ] 
then 
   mkdir ~/Downloads/wp81inst
fi

cd ~/Downloads/wp81inst

echo " "
echo Testing for the wp-full and fonts-16 debs.

test -e ./wp-full_8.1-12_i386.deb 
if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. wp-full is not available. Exiting script."
   exit
fi

test -e ./fonts-16_1.0-5.deb
if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. fonts-16 is not available. Exiting script."
   exit
fi

echo " "
echo Now installing wget deb.
sudo apt install wget

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install wget. Exiting script."
   exit
fi

echo " "
echo Downloading the wp-utils utility, if necessary.
echo " "

test -e ./wp-utils_1.0_i386.deb
if ! [ $? = 0 ] 
then 
   wget https://grumbeer.dyndns.org/ftp/cdroms/corel/installation-1.0-de/dists/corellinux-1.0/corel/binary-i386/wp-utils_1.0_i386.deb
fi
  
if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. wp-utils is not availiable. Exiting script."
   exit
fi

test -e ./ldso_1.9.11-15_i386.deb
if ! [ $? = 0 ] 
then 
   wget https://grumbeer.dyndns.org/ftp/cdroms/corel/installation-1.0-de/dists/corellinux-1.0/corel/binary-i386/ldso_1.9.11-15_i386.deb
fi

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. ldso is not available. Exiting script."
   exit
fi

test -e ./libc5_5.4.46-15_i386.deb
if ! [ $? = 0 ] 
then 
   wget https://grumbeer.dyndns.org/ftp/cdroms/corel/installation-1.0-de/dists/corellinux-1.0/corel/binary-i386/libc5_5.4.46-15_i386.deb
fi

if ! [ $? = 0 ] 
   then 
   echo " "
   echo "Command failed. libc5 is not available. Exiting script."
   exit
fi

echo " "
echo Now installing wp-utils.
sudo dpkg -i wp-utils_1.0_i386.deb

if ! [ $? = 0 ] 
then 
   echo "Command failed. Unable to install xlib6g. Exiting script."
   exit
fi

echo " "
echo Now installing libc6:i386.
sudo apt install libc6:i386

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install libc6:i386. Exiting script."
   exit
fi

echo " "
echo Now installing ldso.
sudo dpkg -i ldso_1.9.11-15_i386.deb

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install ldso. Exiting script."
   exit
fi

echo " "
echo Now installing libc5.
sudo dpkg -i libc5_5.4.46-15_i386.deb

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install libc5. Exiting script."
   exit
fi

echo " "
echo Now running ldconfig.
sudo ldconfig

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to run ldconfig. Exiting script."
   exit
fi

echo " "
echo Now installing alien.
sudo apt install alien

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install alien. Exiting script."
   exit
fi

echo " "
echo Now installing groff.
sudo apt install groff

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install groff. Exiting script."
   exit
fi

echo " "
echo Now installing perl.
sudo apt install perl

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install perl. Exiting script."
   exit
fi

echo " "
echo Now installing xbase-clients.
sudo apt install xbase-clients

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install xbase-clients. Exiting script."
   exit
fi

echo " "
echo Now converting and then installing fonts-16.
sudo alien -t fonts-16_1.0-5.deb

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. fonts-16 are not available. Exiting script."
   exit
fi

sudo installpkg fonts-16-1.0.tgz

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install fonts-16. Exiting script."
   exit
fi

echo " "
echo Now converting and then installing fonts-69 and fonts-115, 
echo if available.

test -e fonts-69_1.0-4.deb
if [ $? = 0 ] 
then 
   sudo alien -t fonts-69_1.0-4.deb
fi

test -e fonts-69-1.0.tgz
if [ $? = 0 ] 
then 
   sudo installpkg fonts-69-1.0.tgz
fi

test -e fonts-115_1.0-4.deb
if [ $? = 0 ] 
then 
   sudo alien -t fonts-115_1.0-4.deb
fi

test -e fonts-115-1.0.tgz
if [ $? = 0 ] 
then 
    sudo installpkg fonts-115-1.0.tgz
fi

echo " "
echo Now converting and then installing wp-full.
sudo alien -t wp-full_8.1-12_i386.deb

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to convert wp-full. Exiting script."
   exit
fi

sudo installpkg wp-full-8.1.tgz

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to install wp-full. Exiting script."
   exit
fi

echo " "
cd /usr/X11R6/lib/X11/fonts/Type1

echo Now running type1inst.
sudo type1inst

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to run type1inst. Exiting script."
   exit
fi

echo " "
echo Now running mkfontdir.
sudo mkfontdir

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to run mkfontdir. Exiting script."
   exit
fi

echo " "
echo Now running wpfi.
sudo /usr/lib/wp8/shbin10/wpfi

if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to run wpfi. Exiting script."
   exit
fi

echo " "
echo Now copying fonts to whole system.
sudo cp -r /usr/X11R6/lib/X11/fonts/Type1/* /usr/share/fonts/type1/*

if ! [ $? = 0 ] 
   then 
   echo " "
   echo "Command failed. Unable to copy fonts to the whole system." 
   echo "Exiting script."
   exit
fi

echo " "
echo Now creating a link to /etc/printcap, if necessary.

test -e /etc/printcap
if ! [ $? = 0 ] 
then 
   sudo ln -s /run/cups/printcap /etc/printcap
fi
   
echo " "
echo "Now copying the WP Print Manager executable."

cd /usr/lib/wp8/shbin10

test -e ./xwppmgr.bin
if ! [ $? = 0 ] 
then 
    sudo cp ./xwppmgr ./xwppmgr.bin
fi

test -e ./xwppmgr.bin
if ! [ $? = 0 ] 
then 
   echo " "
   echo "Command failed. Unable to create xwppmgr.bin."
   echo "Exiting script."
   exit
fi

echo " "
echo WordPerfect 8.1 has been successfully installed,
echo along with an updated version of the WP Print Manager.
echo " "
echo You should now be able to run WordPerfect 8.1 by giving,
echo at the command prompt, any of these commands:
echo "   " \"xwp\", \"/usr/bin/xwp\", or \"/usr/lib/wp8/wpbin/xwp\" 
echo " "
echo You can also run WordPerfect from the Office folder
echo in your Linux menu.
echo " "
echo If, when first running WordPerfect, you get an error referring 
echo to \"too many processes\", you should run WordPerfect once 
echo as administrator, by giving the command: 
echo "   " \"sudo /usr/bin/xwp -admin\"
echo " "
echo To run the WP Print Manager, give the command:
echo "   " \"sudo xwppmgr\"
echo " "
echo You can also run these commands from the Office folder
echo in your Linux menu.
echo " "
echo Enjoy!
echo " "
exit
