# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone --depth=1 ssh://git@github.com/ZenkaBestia/device_xiaomi_lmi-a13.git -b 13-evox device/xiaomi/lmi
git clone --depth=1 ssh://git@github.com/ZenkaBestia/vendor_xiaomi_lmi-a13.git -b 13-elixir-sun vendor/xiaomi/lmi
git clone --depth=1 ssh://git@github.com/ZenkaBestia/kernel_xiaomi_lmi-a13.git -b NGK-t-caf kernel/xiaomi/lmi

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch evolution_lmi-user
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
mka evolution -j16  > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
