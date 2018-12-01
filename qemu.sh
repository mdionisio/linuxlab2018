#!/bin/bash

extraparam=

if [ x$1 = "xstop" ]; then
	killall qemu-system-arm
else

	if [ x$1 = "xdebug" ]; then
		extraparam="${extraparam} -s -S"
	fi
	
	if [ x$1 = "xgdb" ]; then
		cd ./linux
		gdb-multiarch -tui \
			-ex "target remote tcp:localhost:1234"                                      \
			-ex "break qemu-test.c:qemudev_irq_handler"   \
			-ex "break qemu-test.c:qemudev_read"               \
			-ex "break qemu-test.c:qemudev_write"             \
			./vmlinux
		cd ..
	else
		./qemu/arm-softmmu/qemu-system-arm  ${extraparam} -m 512 -M sabrelite \
			-kernel ./linux/arch/arm/boot/zImage \
			-initrd initrd-test.img.gz \
			-append "console=ttymxc0" \
			-dtb ./linux/arch/arm/boot/dts/imx6q-sabrelite.dtb \
			-global mytest.data1=2 \
			-serial mon:stdio \
			-nographic \
			-monitor telnet:127.0.0.1:55555,server,nowait
	fi
fi
