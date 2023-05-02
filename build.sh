# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BootleggersROM/manifest.git -b tirimbino -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone --depth=1 ssh://git@github.com/ZenkaBestia/device_xiaomi_lmi-a13.git -b Tirimbino device/xiaomi/lmi
git clone --depth=1 ssh://git@github.com/ZenkaBestia/vendor_xiaomi_lmi-a13.git -b Tirimbino vendor/xiaomi/lmi
git clone --depth=1 ssh://git@github.com/ZenkaBestia/kernel_xiaomi_lmi-a13.git -b zen_plus-13 kernel/xiaomi/lmi
git clone --depth=1 https://gitlab.com/ZenkaBestia/device_xiaomi_lmi_prebuilt-apps -b main device/xiaomi/lmi-prebuilt-apps
git clone --depth=1 https://github.com/KProfiles/android_packages_apps_Kprofiles -b main packages/apps/KProfiles

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch bootleg_lmi-user
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
mka bootleg -j16  > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
