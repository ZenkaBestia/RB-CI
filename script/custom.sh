#!/usr/bin/env bash

set -exv
name_rom=$(grep init $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d / -f 4)
mkdir -p $WORKDIR/rom/$name_rom
cd $WORKDIR/rom/$name_rom
rm -rf frameworks/base
rm -rf vendor/aospa
rm -rf packages/apps/Settings
rm -rf packages/apps/Launcher3
rm -rf packages/apps/ParanoidSense
rm -rf device/qcom/common
rm -rf vendor/qcom/common
git clone --depth=1 https://github.com/gotenksIN/android_frameworks_base -b topaz-qpr1 frameworks/base
git clone --depth=1 https://github.com/gotenksIN/android_vendor_aospa -b topaz vendor/aospa
git clone --depth=1 https://github.com/gotenksIN/android_packages_apps_Settings -b topaz packages/apps/Settings
git clone --depth=1 https://github.com/gotenksIN/android_packages_apps_Launcher3 -b topaz packages/apps/Launcher3
git clone --depth=1 https://github.com/gotenksIN/android_device_qcom_common -b topaz device/qcom/common
git clone --depth=1 https://github.com/gotenksIN/proprietary_vendor_qcom_common -b topaz vendor/qcom/common
rm -rf vendor/aospa/products/lmi/aospa.dependencies
rclone copy gdrive:aospa.dependencies vendor/aospa/products/lmi
