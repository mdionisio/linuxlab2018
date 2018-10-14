#!/bin/bash
 
#Remove old files
sudo rm -rf rootfs
 
#Create new rootfs folder
sudo mkdir rootfs
sudo cp busybox/_install/* rootfs/ -raf
sudo cp linux/_install/* rootfs/ -raf
#sudo cp mytestmodules/*.ko rootfs/lib/modules/4.18.11/kernel/drivers/
 
#Create folders required by Linux convention
sudo mkdir -p rootfs/proc/
sudo mkdir -p rootfs/sys/
sudo mkdir -p rootfs/tmp/
sudo mkdir -p rootfs/root/
sudo mkdir -p rootfs/var/
sudo mkdir -p rootfs/mnt/
sudo mkdir -p rootfs/dev/

sudo cp ./init ./rootfs
 
rm -f initrd-test.img
cd rootfs ; find . | cpio -o -H newc > ../initrd-test.img ; cd ..
rm initrd-test.img.gz
gzip initrd-test.img