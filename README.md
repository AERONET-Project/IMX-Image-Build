# IMX-Image-Build
Image build for IMX6 Based ANTs 

`sudo apt-get --fix-missing update` 

`sudo apt-get upgrade` 

`sudo apt-get install gawk wget git diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm picocom ncurses-dev lzop gcc-arm-linux-gnueabihf `


OBTAINED BASELINE BUILD ENVIRONMENT (possible) 


Critical path as follows [Shamelessly forked from usbarmory makefile](https://github.com/usbarmory/usbarmory-debian-base_image/blob/master/Makefile)

may be better to use the (Official NXP instructions?)[https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/Install-Debian-8-Jessie-Rootfs-on-NXP-i-MX6ULL-EVK-board/ta-p/1128890] 

Alternative notes of (Variscite imx6 build script with patches)[https://github.com/varigit/debian-var/blob/debian_jessie_mx6ul_var01/make_var_mx6ul_dart_debian.sh] 


* obtain uboot 
* add uboot patches with device trees and kcofnigs, that have configuration for DDR ram, pinmuxes, boot devices etc 
* then compile u-boot into it's requisite images 
* fetch debian .deb dependencies? 
* quemu debootstrap then install via quemu 
* create image from components or something? 
