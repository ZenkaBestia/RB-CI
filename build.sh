# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b topaz -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone --depth=1 ssh://git@github.com/ZenkaBestia/device_xiaomi_lmi-a13.git -b topaz device/xiaomi/lmi
git clone --depth=1 ssh://git@github.com/ZenkaBestia/vendor_xiaomi_lmi-a13.git -b topaz vendor/xiaomi/lmi
git clone --depth=1 ssh://git@github.com/ZenkaBestia/kernel_xiaomi_lmi-a13.git -b topaz-next8 kernel/msm-4.19

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

export KBUILD_BUILD_USER=ZenkaBestia
export KBUILD_BUILD_HOST=Linux-VM
export BUILD_USERNAME=ZenkaBestia
export BUILD_HOSTNAME=Linux-VM
lunch aospa_lmi-user
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
./rom-build.sh lmi -t user -v beta -j 6 > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
