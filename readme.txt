# pre-requisiti

apt-get install build-essential
apt-get install crossbuild-essential-armhf
apt-get install gcc-arm-linux-gnueabihf
apt-get install gcc-arm-none-eabi
apt-get install libncurses5-dev
apt-get install bison flex libssl-dev bc
apt-get install python pkg-config libglib2.0-dev libpixman-1-dev
apt-get install sudo cpio lzop gzip kmod
apt-get install gdb-multiarch

# installazione busybox

cd busybox

ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make menuconfig

Busybox Settings ---> Build Options --->
[*] Build BusyBox as a static binary (no shared libs)

ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4

rm -rf _install ; mkdir _install ; ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CONFIG_PREFIX=_install install 

cd ..


cd llinux

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- imx_v6_v7_defconfig

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 menuconfig

# installazione kernel  (kernel mytest)

  Kernel hacking  --->
        [*] KGDB: kernel debugger  --->
                <*>   KGDB: use kgdb over the serial console
        -> Compile-time checks and compiler options
                [*] Compile the kernel with debug info
		[*] Generate dwarf4 debuginfo
		[*] Provide GDB scripts for kernel debugging
		
	-- Device Driver
		-- Misc Device
			Mytest   [non come modulo per semplificare il debug]

# installazione kernel  (kernel master)

  Kernel hacking  --->
        [*] KGDB: kernel debugger  --->
                <*>   KGDB: use kgdb over the serial console
        -> Compile-time checks and compiler options
                [*] Compile the kernel with debug info
		[*] Generate dwarf4 debuginfo
		[*] Provide GDB scripts for kernel debugging
		
	-- Device Driver
		-- Misc Device
			QEMU test driver   [non come modulo per semplificare il debug]

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 



rm -rf _install ; mkdir _install ; make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4 modules_install INSTALL_MOD_PATH=$(pwd)/_install

cd ..

# build qemu

cd qemu

./configure --target-list=arm-softmmu

make -j4

cd ..

# build cortex-a9

cd cortex-a9

make

cd ..

# create rootfs

./create.sh

# start linux (TEST)

./qemu.sh

cat /proc/iomem  | grep qemu
cat /proc/interrupts  | grep qemu

cat /dev/qemu-test-0
echo "1" > /dev/qemu-test-0
cat /proc/interrupts  | grep qemu
echo "2" > /dev/qemu-test-0
cat /dev/qemu-test-0







