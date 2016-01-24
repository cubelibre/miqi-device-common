#!/bin/bash
echo "$1 $2 $3 $4 $5"
TARGET_PRODUCT=$1
PRODUCT_OUT=$2
TARGET_BOARD_PLATFORM=$3
TARGET_ROCKCHIP_PCBATEST=$4
TARGET_ARCH=$5

PCBA_PATH=external/rk-pcba-test

############################################################################################
#rk recovery contents
############################################################################################
cp -f vendor/rockchip/common/bin/$TARGET_ARCH/busybox $PRODUCT_OUT/recovery/root/sbin/
cp -f vendor/rockchip/common/bin/$TARGET_ARCH/newfs_msdos $PRODUCT_OUT/recovery/root/sbin/
cp -f vendor/rockchip/common/bin/$TARGET_ARCH/sh $PRODUCT_OUT/recovery/root/sbin/

if [ $TARGET_ROCKCHIP_PCBATEST = "true" ];then
cp -f $PRODUCT_OUT/obj/EXECUTABLES/codec_test_intermediates/codec_test $PRODUCT_OUT/recovery/root/sbin/
cp -f $PRODUCT_OUT/obj/EXECUTABLES/pcba_core_intermediates/pcba_core $PRODUCT_OUT/recovery/root/sbin/

cp -rf $PCBA_PATH/bin/* $PRODUCT_OUT/recovery/root/sbin/
cp -rf $PCBA_PATH/res/* $PRODUCT_OUT/recovery/root/res/

echo "rk-pcba-test/res.sh $TARGET_PRODUCT $PRODUCT_OUT $TARGET_BOARD_PLATFORM"
$PCBA_PATH/res.sh $TARGET_PRODUCT $PRODUCT_OUT $TARGET_BOARD_PLATFORM
fi

#miqi recovery contents
mkdir -p $PRODUCT_OUT/recovery/root/system/bin
ln -sf ../../sbin/sh $PRODUCT_OUT/recovery/root/system/bin/sh
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/unzip
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/ls
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/ln
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/grep
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/chmod
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/vi
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/rm
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/chown
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/mount
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/umount
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/clear
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/dd
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/cp
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/mv

# OpenGApps
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/sort
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/sed
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/find
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/dirname
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/cut
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/head
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/install
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/printf
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/df

# system require
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/basename
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/xargs
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/awk
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/tail

# touch
cp -f vendor/rockchip/common/bin/$TARGET_ARCH/touch $PRODUCT_OUT/recovery/root/sbin/
# tar opengapps need tar support stdin
# mountpoints

# just for handy to use
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/mkdir
ln -sf busybox $PRODUCT_OUT/recovery/root/sbin/which

# to avoid build system dangling symlink error
# will replace later
touch $PRODUCT_OUT/recovery/root/etc/recovery.emmc.fstab
ln -sf recovery.emmc.fstab $PRODUCT_OUT/recovery/root/etc/fstab
ln -sf recovery.emmc.fstab $PRODUCT_OUT/recovery/root/etc/recovery.fstab

# openGApps is looking here
ln -sf ../default.prop $PRODUCT_OUT/recovery/root/system/default.prop
ln -sf ../default.prop $PRODUCT_OUT/recovery/root/system/build.prop

