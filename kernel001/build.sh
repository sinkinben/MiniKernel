#########################################################################
# File Name: build.sh
# Author: sinkinben
# E-mail: sinkinben@qq.com
# Created Time: Thu 23 May 2019 12:03:44 PM CST
#########################################################################
#!/bin/bash

nasm -f elf32 -o boot.o boot.asm
gcc -m32 -c -o kernel.o kernel.c
ld -m elf_i386 -T script.lds -o boot.img boot.o kernel.o
qemu-system-i386 boot.img 
