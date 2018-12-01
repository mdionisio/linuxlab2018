#!/bin/bash
 
#Remove old files
rm -rf rootfs 2>/dev/null >/dev/null
 
#Create new rootfs folder
mkdir rootfs
cp busybox/_install/* rootfs/ -raf
cp linux/_install/* rootfs/ -raf
#cp mytestmodules/*.ko rootfs/lib/modules/4.18.11/kernel/drivers/
 
#Create folders required by Linux convention
mkdir -p rootfs/proc/
mkdir -p rootfs/sys/
mkdir -p rootfs/tmp/
mkdir -p rootfs/root/
mkdir -p rootfs/var/
mkdir -p rootfs/mnt/
mkdir -p rootfs/dev/

cp ./init ./rootfs
 
rm -f initrd-test.img 2>/dev/null >/dev/null
cd rootfs ; find . | cpio -o -H newc -R +0:+0 > ../initrd-test.img ; cd ..
rm initrd-test.img.gz
gzip initrd-test.img
rm -rf rootfs