#!/bin/sh
## Emulated TPM 2.0 device
mkdir /tmp/emulated_tpm
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
-display egl-headless,rendernode=/dev/dri/card0,gl=on \
-device qxl-vga,id=video0,ram_size=134217728,vram_size=134217728,vgamem_mb=512 \
-spice disable-ticketing=on,image-compression=off,seamless-migration=on,unix=on,addr=/run/user/1000/spice.sock,gl=on \
-device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent \
-device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
-drive file=hda.img,if=virtio,cache.direct=on,aio=native,format=qcow2 \
-boot c \
-monitor stdio
