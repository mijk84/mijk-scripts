# mijk-scripts #

Batch files, shell scripts, modified code to help cross-compile.

----------
## mkflp
>Create a floppy image from the files in the current directory.

## dosslip.sh
>SLIP setup for DOSBox.
>  
>You will need the following packages:  
>>socat slattach dosbox unzip wget  
>  
>Create a TCP.CFG file under ./mnt/NET with the following:
>>hostname dosslip  
>>PACKETINT 0x60  
>>IPADDR 192.168.7.2  
>>NETMASK 255.255.255.252  
>>GATEWAY 192.168.7.1  
>>NAMESERVER 8.8.8.8  
>>LEASE_TIME 600  

## dosslip.cnf
>This is a normal and editable dosbox.conf. The most important is what is in the SERIAL and AUTOEXEC sections. You're best to download this and work from there.

## sysinfo.sh
>Just some silly script I wrote with the basic bash knowledge I know. Great for pasting into chat rooms to brag about your computer.

## sysinfo.cmd
>Just some silly script I wrote with the basic batch knowledge I know. Great for pasting into chat rooms to brag about your computer.

## rssfeed.rb
>A Ruby script that parses RSS feeds.

## getshows.sh
>Downloads TV shows from an RSS feed, requires rssfeed.rb

## update-media-player.sh
>Finds movies and organizes them in a specific folder.
