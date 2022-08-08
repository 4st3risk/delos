#!/bin/sh
set -e 
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/delos.kernel isodir/boot/delos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "delos" {
	multiboot /boot/delos.kernel
}
EOF
grub-mkrescue -o delos.iso isodir

