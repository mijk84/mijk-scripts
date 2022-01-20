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

## ubuntu.cmd
>This is a Qemu VM that runs headless. The reason I did this was so that I can run NoMachine and capture the keyboard. Alt-Tab, Win-Tab, Ctrl-Alt-Delete stays within the VM itself. There doesn't seem to be any performance degredation. The "hv-" options for the virtual CPU were brought to my attention in that they would increase the performance of Windows 10 VM's. I'm not certain if this is the case for any other VM or if it's even implemented in Qemu for Windows. The hostfwd options allow for SSH access and for NoMachine to work.

## mijksrv-vm-w11.sh
>This is a Qemu VM that runs in EGL optimized headless mode. It's been set up to allow RDP access. It's been optimized to use RAM to its fullest and use virtio-vga-gl-pci. Since I don't have a 2nd video card in my Qemu VM server, then this is the best that I can do.

## mijkify.sh
>This is a script I use to install GUI and CLI packages that I install on basically all Debian-based OS'.

## mkdsk
>This is a fork I made of a Novaspirit script I found here: https://www.novaspirit.com/2017/03/28/running-mac-os-7-on-raspberry-pi-with-color/
>I don't know if he ever hosted it on github or not.

## ovmf-update.cmd
>This is a script I created to update the OVMF files I use for qemu VM's in Windows. (the BIOS)

## ovmf-update.sh
>This is a script that I created to update OVMF files in Debian-based OS'

## pantheonize.sh
>This is a script I created to install Pantheon in Ubuntu, basically turning it into elementary OS.

## qemu-update.cmd
>This is a script I created to find the latest release of Qemu for Windows 64 bit and download it.

## sysinfo.cmd
>This is a script to copy your system information to the clipboard in Windows.

## sysinfo.sh
>This is a script to copy your system information to the clipboard in Linux.

## ubuntu.cmd
>This is a Windows Qemu launcher for a Ubuntu VM

## unlauncher
>This is a script I made that you pass a .desktop to and it will find the exec line and just run it from the terminal.
