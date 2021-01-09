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

## ubuntu.cmd
>This is a Qemu VM that runs headless. The reason I did this was so that I can run NoMachine and capture the keyboard. Alt-Tab, Win-Tab, Ctrl-Alt-Delete stays within the VM itself. There doesn't seem to be any performance degredation. The "hv-" options for the virtual CPU were brought to my attention in that they would increase the performance of Windows 10 VM's. I'm not certain if this is the case for any other VM or if it's even implemented in Qemu for Windows. The hostfwd options allow for SSH access and for NoMachine to work.

## mijksrv-vm-w10.sh
>This is a Qemu VM that runs in EGL optimized headless mode. It's been set up to allow RDP access. It's been optimized to use RAM to its fullest and use QXL to its fullest. Since I don't have a 2nd video card in my Qemu VM server, then this is the best that I can do.
