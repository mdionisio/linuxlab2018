#!/bin/bash

extraparam=

if [ x$1 = "xstop" ]; then
	killall qemu-system-arm
else

	if [ x$1 = "xdebug" ]; then
		extraparam="${extraparam} -s -S"
	fi

	./qemu/arm-softmmu/qemu-system-arm  ${extraparam} -m 512 -M sabrelite \
	-kernel ./linux/arch/arm/boot/zImage \
	-initrd initrd-test.img.gz \
	-append "console=ttymxc0" \
	-nographic -dtb ./linux/arch/arm/boot/dts/imx6q-sabrelite.dtb 
	
fi
