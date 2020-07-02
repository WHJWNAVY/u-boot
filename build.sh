#!/bin/bash

source ./setenv.sh

NUM_CPUS=$(cat /proc/cpuinfo | grep -c processor)

if [ "$1" = "nand" ]; then
    echo "build nand uboot"
    make mx28evk_nand_defconfig
else
    echo "build mmc uboot"
    make mx28evk_defconfig
fi

make -j${NUM_CPUS} spl/u-boot-spl
make -j${NUM_CPUS} u-boot
elftosb -f imx28 -c arch/arm/cpu/arm926ejs/mxs/u-boot-imx28.bd -o u-boot.sb
#cp -rf ./u-boot.sb /home/john/share/imx280/工具/烧写工具/cfimager/imx28_ivt_uboot.sb && sync

