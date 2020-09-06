#!/bin/bash
# dev1 Webcam
# dev2 Bluetooth Radio

dev1=13d3:5a11
dev2=13d3:3529
cnt=0

for x in $dev1 $dev2
do
        cnt=$[$(echo $cnt) + 1]
        IFS=: read addr1dev${cnt} addr2dev${cnt} <<< $x
done

qemu-system-x86_64 \
-cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff \
-bios /usr/share/ovmf/OVMF.fd \
-M q35,accel=kvm,kernel-irqchip=split \
-device amd-iommu,intremap=on \
-rtc base=localtime \
-smp 8,sockets=1,cores=8,threads=1 \
-m 6144 \
-device virtio-net-pci,netdev=net0 -netdev user,hostfwd=tcp::3389-:3389,id=net0 \
-usb -device usb-kbd \
-device nec-usb-xhci,id=usb \
-device usb-host,vendorid=0x$addr1dev1,productid=0x$addr2dev1,id=usb.0 \
-device usb-host,vendorid=0x$addr1dev2,productid=0x$addr2dev2,id=usb.1 \
-device ich9-intel-hda -device hda-output \
-display none \
-device qxl-vga \
-global qxl-vga.vram_size_mb=128 -global qxl-vga.ram_size_mb=512 \
-device nec-usb-xhci,id=xhci \
-device virtio-serial-pci \
-spice unix,addr=windows.socket,disable-ticketing,image-compression=auto_glz,jpeg-wan-compression=always,playback-compression=off,zlib-glz-wan-compression=never,streaming-video=filter,agent-mouse=on,gl=on \
-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
-chardev spicevmc,id=spicechannel0,name=vdagent \
-drive file=hda.img,if=virtio,cache.direct=on,aio=native,format=raw \
-boot c \
-monitor stdio
