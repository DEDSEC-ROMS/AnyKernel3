### AnyKernel setup
# begin properties
properties() { '
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=daisy
supported.versions=
supported.patchlevels=
'; } # end properties

### AnyKernel install
# begin attributes
attributes() {
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;
} # end attributes


## boot shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh && attributes;

# boot install
dump_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

write_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
## end boot install

mount -o remount,rw /vendor

# Check if the script is present if so nuke it
sed -i '/revvz_exec/d' /vendor/bin/init.qcom.sh
sed -i '/revvz_exec/d' /vendor/bin/init.qcom.post_boot.sh
sed -i '/sleepy_exec.sh/d' /vendor/bin/init.qcom.sh
sed -i '/sleepy_exec.sh/d' /vendor/bin/init.qcom.post_boot.sh
rm -rf /vendor/bin/revvz_exec.sh
rm -rf /vendor/bin/sleepy_exec.sh
## end vendor_boot install
