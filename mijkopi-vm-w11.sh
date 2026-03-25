#!/bin/sh
## Emulated TPM 2.0 device
mkdir /tmp/emulated_tpm
touch /tmp/foo-cancel
swtpm socket \
--tpmstate dir=/tmp/emulated_tpm \
--ctrl type=unixio,path=/tmp/emulated_tpm/swtpm-sock \
--log level=20 \
--tpm2 \
--daemon

## QEMU VM
taskset --cpu-list 4-7 qemu-system-aarch64 \
-nodefaults \
-cpu host \
-drive if=pflash,format=raw,readonly=on,file=OVMF_CODE.secboot.fd \
-drive if=pflash,format=raw,file=OVMF_VARS.fd \
-M virt,accel=kvm \
-rtc base=localtime \
-smp 4,sockets=1,cores=4,threads=1 \
-m 7168 \
    -mem-prealloc \
-chardev socket,id=chrtpm,path=/tmp/emulated_tpm/swtpm-sock \
-tpmdev emulator,id=tpm0,chardev=chrtpm \
-device tpm-tis-device,tpmdev=tpm0 \
-device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::3389-:3389,hostfwd=tcp::4000-:4000,hostfwd=tcp::4080-:4080,hostfwd=tcp::4443-:4443 \
-device nec-usb-xhci,id=xhci \
-device usb-kbd,bus=xhci.0 -device usb-tablet,bus=xhci.0 \
-display egl-headless,rendernode=/dev/dri/card0,gl=on \
-device virtio-gpu,hostmem=128M \
-device usb-host,bus=xhci.0,vendorid=0x17e9,productid=0x4301 \
-spice port=9000,addr=127.0.0.1,disable-ticketing=on \
-device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent \
-device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
-drive file=hda.img,if=virtio,cache.direct=on,aio=native,format=qcow2 \
-boot c \
-monitor stdio
