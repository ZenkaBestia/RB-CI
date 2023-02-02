#!/usr/bin/env bash

cd $WORKDIR
mkdir -p ~/.ssh
echo "$SSH_KEY" > ~/.ssh/id_rsa
echo "$SSH_PUB" > ~/.ssh/id_rsa.pub
chmod 0600 ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa.pub
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts
mkdir -p ~/.config/rclone
echo "$RCLONECONFIG_DRIVE" > ~/.config/rclone/rclone.conf
name_rom=$(grep init $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d / -f 4)
device=$(grep lunch $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
rclone copy zendrive:ccache/$name_rom/$device/ccache.tar.gz $WORKDIR -P --stats 1s
tar xzf ccache.tar.gz
rm -rf ccache.tar.gz
