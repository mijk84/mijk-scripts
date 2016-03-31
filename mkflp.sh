#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
dd bs=512 count=2880 if=/dev/zero of=~/floppy.img
mkfs.msdos ~/floppy.img
mount -o loop ~/floppy.img /mnt/img/
mv * /mnt/img/
sleep 2
umount /mnt/img/
mv ~/floppy.img ./
