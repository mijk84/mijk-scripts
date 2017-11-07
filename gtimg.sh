#!/bin/sh
# Gotek Floppy Imager
#
# eg. gtimg.sh 2 disk2.img /dev/mmcblk0
#
# $3 = /dev/mmcblk0
# $2 = disk2.img
# $1 = 2 (x 1536 for seek)
#
# dd if=./$2 of=/dev/mmcblk0 bs=1024 count=1440 seek=$1 conv=notrunc
