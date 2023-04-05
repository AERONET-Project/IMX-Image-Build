#!/bin/bash 

#This is the jank as hell builder script to fully automate spitout of a bootable img of Debian for the IMX6 based ANT




#obtain toolchain
#cd ~/
#wget -c https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-i686-mingw32_arm-linux-gnueabihf.tar.xz 
#mkdir toolchain 
#tar xvf gcc-linaro-7.5.0-2019.12-i686-mingw32_arm-linux-gnueabihf.tar.xz -C toolchain/ --strip-components 1
echo "Downloading toolchain" 
sudo apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf 
export ARCH=arm 
export CROSS_COMPILE=arm-linux-gnueabihf-
mkdir out 
#Aight toolchain get 
#now on to das U-boot 


wget -c https://github.com/u-boot/u-boot/archive/refs/tags/v2023.04.tar.gz 
mkdir u-boot-imx
tar -xf v2023.04.tar.gz -C uboot-imx/ --strip-components 1 
cd u-boot-imx
#Pause for copying over patches and other stuff to config uboot for specific configuration of hardware 
# specifically pinmuxes, patches to mmc boot location and other stuff 
#copy over new defconfig (not yet generated) 
make mx6ulz_14x14_evk_defconfig -j'nproc' 
#make mx6ulz_ANT_Alpha_defconfig 
make 
#bwoop bwoop das boot is ready 

#get KFC out cause it's kernel time 
cd ..
wget -c https://github.com/nxp-imx/linux-imx/archive/refs/tags/rel_imx_5.4.24_2.1.4.tar.gz 
mkdir linux-imx
tar -xf rel_imx_5.4.24_2.1.4.tar.gz  -C linux-imx/ --strip-components 1 
cd linux-imx 
# pause to copy over all the stuff for device trees and other modifications to match hardware of choice. 
make imx_v7_defconfig -j'nproc'
#make dtbs 
make zImage dtbs -j'nproc'

#movign uboot, kernel and dtb to folder 
cd ..
sudo cp uboot-imx/u-boot.imx  out/
sudo cp linux-imx/arch/arm/boot/zImage  out/
sudo cp linux-imx/arch/arm/boot/dts/imx6ull-14x14-evk.dtb  out/


#time to build a rootfs baseline from scratch because apparently no such thing exists online yet? PAIN 
wget -c https://rcn-ee.com/rootfs/eewiki/minfs/debian-11.6-minimal-armhf-2022-12-20.tar.xz
mkdir rootfs 
tar xvf debian-11.6-minimal-armhf-2022-12-20.tar.xz -C rootfs/ --strip-components 1 
cd rootfs/./debian-11.6-minimal-armhf-2022-12-20
tar jcvf armhf-rootfs-debian-bullseye.tar.bz2 ./* 
sudo mv armhf-rootfs-debian-bullseye.tar.bz2 ../out
#ok baseline build SHOULD be in the /out folder now, all components ready. 

