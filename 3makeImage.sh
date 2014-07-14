#!/bin/bash
function makeimage {
  packages="$1"
  target=$2
  profile=$3
  factory=$4
  sysupgrade=$5
  (
    cd OpenWrt-ImageBuilder-${target}-for-linux-x86_64/
    make clean
    rm -rf myfiles/

    mkdir myfiles
    cp ../files/_all/* myfiles/ -r -v
    tmp_str=${sysupgrade}
    sed -i -e "s/#xxxFILENAMExxx/option filename 'ff-nrw-$tmp_str'/" myfiles/etc/config/freifunk
    make image FILES="./myfiles/" PROFILE="${profile}" PACKAGES="$packages"
    cp bin/*/openwrt-${sysupgrade} ../images
    cp bin/*/openwrt-${factory} ../images
  ) 2>&1 | tee logs/makeimage-${profile}
}

rm images/*

BUILD=$(cat build.txt) 
BUILD=$(($BUILD+1))
echo $BUILD > build.txt


CFGMINI="-6relayd -kmod-wpad -odhcp6c -odhcpd -wpad-mini kmod-batman-adv batctl ebtables ip curl ecdsautils"
CFGBASE="$CFGMINI ppp-mod-pppoe haveged socat tc kmod-sched-core kmod-sched"
CFGHOTSPOT="hostapd kmod-ath"
CFGVPN="fastd"
CFGx86="kmod-ide-core kmod-ide-generic"

echo $BUILD > files/_all/build
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR740' ar71xx-generic-tl-wr740n-v4-squashfs-factory.bin ar71xx-generic-tl-wr740n-v4-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR741' ar71xx-generic-tl-wr741nd-v2-squashfs-factory.bin ar71xx-generic-tl-wr741nd-v2-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR741' ar71xx-generic-tl-wr741nd-v4-squashfs-factory.bin ar71xx-generic-tl-wr741nd-v4-squashfs-sysupgrade.bin

makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR841' ar71xx-generic-tl-wr841n-v8-squashfs-factory.bin ar71xx-generic-tl-wr841n-v8-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR841' ar71xx-generic-tl-wr841n-v9-squashfs-factory.bin ar71xx-generic-tl-wr841n-v9-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR841' ar71xx-generic-tl-wr841nd-v7-squashfs-factory.bin ar71xx-generic-tl-wr841nd-v7-squashfs-sysupgrade.bin

makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR842' ar71xx-generic-tl-wr842n-v1-squashfs-factory.bin ar71xx-generic-tl-wr842n-v1-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR842' ar71xx-generic-tl-wr842n-v2-squashfs-factory.bin ar71xx-generic-tl-wr842n-v2-squashfs-sysupgrade.bin

makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR941' ar71xx-generic-tl-wr941nd-v4-squashfs-factory.bin ar71xx-generic-tl-wr941n-v4-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR941' ar71xx-generic-tl-wr941nd-v6-squashfs-factory.bin ar71xx-generic-tl-wr941n-v6-squashfs-sysupgrade.bin

makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR1043' ar71xx-generic-tl-wr1043nd-v1-squashfs-factory.bin ar71xx-generic-tl-wr1043nd-v1-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWR1043' ar71xx-generic-tl-wr1043nd-v2-squashfs-factory.bin ar71xx-generic-tl-wr1043nd-v2-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLMR3020' ar71xx-generic-tl-mr3020-v1-squashfs-factory.bin ar71xx-generic-tl-mr3020-v1-squashfs-sysupgrade.bin
#makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLMR3040' ar71xx-generic-tl-mr3040-v1-squashfs-factory.bin ar71xx-generic-tl-mr3040-v1-squashfs-sysupgrade.bin
#makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" mpc85xx_generic 'TLWDR4900' mpc85xx-generic-tl-wdr4900-v1-squashfs-factory.bin mpc85xx-generic-tl-wdr4900-v1-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'TLWDR4300' ar71xx-generic-tl-wdr4300-v1-squashfs-factory.bin ar71xx-generic-tl-wdr4300-v1-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'MYNETN600' ar71xx-generic-mynet-n600-squashfs-factory.bin ar71xx-generic-mynet-n600-squashfs-sysupgrade.bin
makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'MYNETN750' ar71xx-generic-mynet-n750-squashfs-factory.bin ar71xx-generic-mynet-n750-squashfs-sysupgrade.bin 

makeimage "$CFGBASE $CFGVPN $CFGHOTSPOT" ar71xx_generic 'WZRHPAG300H' ar71xx-generic-wzr-hp-ag300h-squashfs-factory.bin ar71xx-generic-wzr-hp-ag300h-squashfs-sysupgrade.bin

makeimage "$CFGBASE $CFGVPN $CFGx86" x86_64 '' x86_64-combined-ext4.img.gz x86_64-combined-ext4.img.gz
gzip -dk images/openwrt-x86_64-combined-ext4.img.gz && qemu-img convert -f raw -O vmdk images/openwrt-x86_64-combined-ext4.img images/openwrt-x86_64-combined-squashfs.vmdk && rm images/openwrt-x86_64-combined-ext4.img

makeimage "$CFGMINI $CFGHOTSPOT" atheros '' atheros-ubnt2-squashfs.bin atheros-ubnt2-squashfs.bin 

rename.ul openwrt- ff-nrw- images/*

