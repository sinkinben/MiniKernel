#!/bin/bash
BOOT_PATH=./boot
BUILD_PATH=./build
OBJ_PATH=$BUILD_PATH/obj
BIN_PATH=$BUILD_PATH/bin
INCLUDE_PATH=.

# 得到文件名
get_name()
{
    str=${1%.*}
    str=${str#*/}
    # return $1
}

build_asm()
{
    echo nasm $1 -f $2 -o $3
    nasm $1 -f $2 -o $3
}

build_c()
{
    # str=''
    get_name $1
    str=${str#*/}
    echo gcc -c -m32 -fno-stack-protector -nostdinc -I $INCLUDE_PATH -o $OBJ_PATH/$str.o $1
    gcc -c -m32 -fno-stack-protector -nostdinc -I $INCLUDE_PATH -o $OBJ_PATH/$str.o $1
    
}

set -e 
mkdir -p $OBJ_PATH
mkdir -p $BIN_PATH

#build *.c
c_str=$(find . -name "*.c")
for c in $c_str
do
    build_c $c
done

#build *.asm
build_asm $BOOT_PATH/boot.asm  bin $BIN_PATH/boot.img
build_asm $BOOT_PATH/entry.asm elf $OBJ_PATH/entry.o

#link everything
obj_str=$(find . -name "*.o")
ld -m elf_i386 -Ttext=0xC0010000 -o $BIN_PATH/uxos.elf $obj_str

objcopy -O binary $BIN_PATH/uxos.elf $BIN_PATH/uxos.img
cat $BIN_PATH/boot.img $BIN_PATH/uxos.img > $BIN_PATH/fda.img

#run
qemu-system-i386 -fda $BIN_PATH/fda.img
exit

