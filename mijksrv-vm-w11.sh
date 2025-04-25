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
/usr/local/bin/qemu-system-x86_64 \
-nodefaults \
-cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff \
-global driver=cfi.pflash01,property=secure,value=on \
    -drive if=pflash,format=raw,unit=0,file=OVMF_CODE_4M.secboot.fd,readonly=on \
    -drive if=pflash,format=raw,unit=1,file=OVMF_VARS_4M.fd \
-M q35,smm=on,accel=kvm,kernel-irqchip=split \
-device intel-iommu,intremap=on \
-rtc base=localtime \
-smp 8,sockets=1,cores=4,threads=2 \
-m 8192 \
    -mem-prealloc \
-tpmdev passthrough,id=tpm0,path=/dev/tpm0,cancel-path=/tmp/foo-cancel \
-device tpm-tis,tpmdev=tpm0 \
-device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::3389-:3389 \
-device nec-usb-xhci,id=xhci \
-device usb-kbd,bus=xhci.0 -device usb-tablet,bus=xhci.0 \
-device usb-host,bus=xhci.0,vendorid=0x17e9,productid=0x4301 \
-display egl-headless,rendernode=/dev/dri/card0,gl=on \
-device virtio-gpu,hostmem=268435456 \
-device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent \
-device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
-drive file=hda.img,if=virtio,cache.direct=on,aio=native,format=qcow2 \
-boot c \
-monitor stdio

## Stop swtpm
kill -15 `pidof swtpm`
