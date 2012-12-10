echo "packing ane-device-file-util..."
cd /Volumes/exFAT/anes/ane-device-file-util/as3/bin
adt -package -target ane device-file-util.ane extension.xml -swc device-file-util.swc -platform iPhone-ARM library.swf libDeviceFileUtil.a
echo "Done!"