# mijk-batch #

Batch files, shell scripts, modified code to help cross-compile.

----------
## makefile 

> Makefile to cross-compile Steam IM [plugin](https://github.com/EionRobb/pidgin-opensteamworks) for Pidgin
 
## mkflp
>Create a floppy image from the files in the current directory.

## run.cmd
>Qemu launcher for Windows.

## run.sh
>Qemu launcher for Linux

## dosslip.sh
>SLIP setup for DOSBox.
>
>Create a TCP.CFG file under ./mnt/NET with the following:
>>hostname dosslip  
>>IPADDR 192.168.7.2  
>>NETMASK 255.255.255.252  
>>GATEWAY 192.168.7.1  
>>NAMESERVER 8.8.8.8  
>>LEASE_TIME 600  

## dosslip.cnf
>This is a normal and editable dosbox.conf. The most important is what is in the SERIAL and AUTOEXEC sections. You're best to download this and work from there.
