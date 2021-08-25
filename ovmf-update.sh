#!/bin/bash
# 2021 Mike Ladouceur

# Get the latest OVMF RPM
OVMF=$(curl --silent https://www.kraxel.org/repos/jenkins/edk2/ | grep ovmf | grep x64)
        regex='(<a\ +href=\")([^\"]+)(\">)'
        rpm=$([[ $OVMF =~ $regex ]] && echo ${BASH_REMATCH[2]})
wget https://www.kraxel.org/repos/jenkins/edk2/$rpm

# Extract it and put it in the current directory
rpm2cpio $rpm | cpio -idmv
mv usr/share/edk2.git/ovmf-x64/OVMF-pure-efi.fd .

# Clean up
rm $rpm
rm -fr usr
