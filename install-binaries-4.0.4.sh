#!/bin/sh

DL_URL='https://dl.google.com/dl/android/aosp/imgtec-panda-20120430-67545da7.tgz'
if [ -e "$(realpath $(dirname $0))/`basename $DL_URL`" ]; then
	DL_URL="$(realpath $(dirname $0))/`basename $DL_URL`"
fi

err_handle() {
  echo "Error, please try again"
  exit 1
}

device="$1"
if [ -z "$device" ]; then
    for i in `cat /proc/partitions | awk '{print $4}' |grep -i 'sd[a-z][1-9]\|mmcblk[0-9]p[1-9]'`
    do
        label=`sudo e2label /dev/$i 2>/dev/null`
        if [ "$label" = "system" ]; then
            device="/dev/$i"
        fi
    done
    [ -b "$device" ] || { echo "Failed to find system partition" && exit 1; }
fi

trap 'err_handle' ERR

mkdir -p /tmp/binaries
cd /tmp/binaries/
if [ -e "$DL_URL" ]; then
	tar xf "$DL_URL"
else
	wget --no-check-certificate $DL_URL
	tar -zxvf `basename $DL_URL`
fi
sh extract-imgtec-panda.sh
sudo mount $device /mnt/
sudo mkdir -p /mnt/vendor/bin/
sudo mkdir -p /mnt/vendor/lib/egl
sudo cp vendor/imgtec/panda/proprietary/pvrsrvinit /mnt/vendor/bin/pvrsrvinit
sudo cp vendor/imgtec/panda/proprietary/pvrsrvinit /mnt/bin/pvrsrvinit
sudo chmod a+x /mnt/vendor/bin/pvrsrvinit
sudo cp vendor/imgtec/panda/proprietary/libEGL_POWERVR_SGX540_120.so /mnt/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so 
sudo cp vendor/imgtec/panda/proprietary/libGLESv1_CM_POWERVR_SGX540_120.so /mnt/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so 
sudo cp vendor/imgtec/panda/proprietary/libGLESv2_POWERVR_SGX540_120.so /mnt/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so 
sudo cp vendor/imgtec/panda/proprietary/gralloc.omap4.so /mnt/vendor/lib/hw/gralloc.omap4.so 
sudo cp vendor/imgtec/panda/proprietary/libglslcompiler.so /mnt/vendor/lib/libglslcompiler.so 
sudo cp vendor/imgtec/panda/proprietary/libIMGegl.so /mnt/vendor/lib/libIMGegl.so 
sudo cp vendor/imgtec/panda/proprietary/libpvr2d.so /mnt/vendor/lib/libpvr2d.so 
sudo cp vendor/imgtec/panda/proprietary/libpvrANDROID_WSEGL.so /mnt/vendor/lib/libpvrANDROID_WSEGL.so 
sudo cp vendor/imgtec/panda/proprietary/libPVRScopeServices.so /mnt/vendor/lib/libPVRScopeServices.so 
sudo cp vendor/imgtec/panda/proprietary/libsrv_init.so /mnt/vendor/lib/libsrv_init.so 
sudo cp vendor/imgtec/panda/proprietary/libsrv_um.so /mnt/vendor/lib/libsrv_um.so 
sudo cp vendor/imgtec/panda/proprietary/libusc.so /mnt/vendor/lib/libusc.so
sudo chmod -R 755 /mnt/vendor/lib/
sudo umount -f $device
cd -
sudo rm -r /tmp/binaries
echo "Success, installing binary files"
