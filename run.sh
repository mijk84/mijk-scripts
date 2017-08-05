#!/bin/bash
#run.sh
qemu="qemu-system-i386"
kernel=
initrd=
cpu="core2duo"
m="256"
vga=
soundhw=
device=
hda="hda.img"
cdrom=
fda=
redir="tcp:8022::22"
#Adding a space between brackets tricks the nographic setting into being used.
nographic=" "
boot="c"

for n in kernel initrd cpu m vga soundhw hda cdrom fda device redir boot nographic
do
  if [ -n "${!n}" ]; then
qemurun="$qemurun -$n ${!n}"
  fi
done


$qemu $qemurun
