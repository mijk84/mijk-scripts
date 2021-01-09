@echo off
qemu-system-x86_64 ^
-cpu EPYC,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff ^
-M q35,accel=whpx,kernel-irqchip=split ^
-rtc base=localtime ^
-smp 4,sockets=1,cores=4,threads=1 ^
-m 6144 ^
-device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::4000-:4000,hostfwd=tcp::4080-:4080,hostfwd=tcp::4443-:4443 ^
-device nec-usb-xhci,id=xhci -device usb-kbd -device usb-mouse ^
-device usb-host,bus=xhci.0,hostbus=0,hostaddr=3 ^
-device ich9-intel-hda -device hda-output ^
-display none ^
-device vmware-svga ^
-drive file=hda.img,if=virtio,cache.direct=on,aio=native,format=raw ^
-boot c ^
-monitor stdio
