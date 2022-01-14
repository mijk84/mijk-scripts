#!/bin/sh
## Emulated TPM 2.0 device
mkdir /tmp/emulated_tpm
swtpm socket --tpmstate dir=/tmp/emulated_tpm --ctrl type=unixio,path=/tmp/emulated_tpm/swtpm-sock --log level=20 --tpm2 -d

## QEMU VM
/usr/local/bin/qemu-system-x86_64 \
-nodefaults \
-cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff \
-global driver=cfi.pflash01,property=secure,value=on \
    -drive if=pflash,format=raw,unit=0,file=OVMF_CODE-need-smm.fd,readonly=on \
    -drive if=pflash,format=raw,unit=1,file=OVMF_VARS-need-smm.fd \
-M q35,smm=on,accel=kvm,kernel-irqchip=split \
-device intel-iommu,intremap=on \
-rtc base=localtime \
-smp 4,sockets=1,cores=2,threads=2 \
-m 8192 \
    -object memory-backend-file,id=mem0,mem-path=/dev/hugepages,size=4G -numa node,nodeid=0,memdev=mem0 \
    -object memory-backend-file,id=mem1,mem-path=/dev/hugepages,size=4G -numa node,nodeid=1,memdev=mem1 \
    -mem-prealloc \
-tpmdev passthrough,id=tpm0,path=/dev/tpm0 \
-device tpm-tis,tpmdev=tpm0 \
-device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::3389-:3389 \
-usb -device usb-kbd -device usb-mouse \
-device ich9-intel-hda -device hda-output \
-display egl-headless,rendernode=/dev/dri/card0 \
-device virtio-gpu-gl-pci \
-drive file=/home/mike/qemu/windows/hda.img,if=virtio,cache.direct=on,aio=native,format=raw \
-boot c \
-monitor stdio
