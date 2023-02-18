#!/usr/bin/env bash

set -exv
name_rom=$(grep init $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d / -f 4)
mkdir -p $WORKDIR/rom/$name_rom
cd $WORKDIR/rom/$name_rom
rm -rf packages/apps/ParanoidSense
rm -rf vendor/aospa/products/lmi/aospa.dependencies
rclone copy gdrive:aospa.dependencies vendor/aospa/products/lmi
