#!/bin/bash

# add_user_to_audio_group.sh
#
# Adds a user to audio group.
#
# Project: docker-ubuntu-x
# License: GNU GPLv3
#
# Copyright (C) 2016 Robert Cernansky



if [ "-h" == "$1" ] || [ "--help" == "$1" ] || [ -z $1 ] || [ "" == "$1" ]; then
    cat <<EOF
Usage:
  ${0} <user>
EOF
  exit 0
fi



user=${1}

if ls /dev/snd/pcm* > /dev/null 2>&1; then
    echo "ensuring that the user is in the audio group"

    audioGroupId=$(stat -c %g /dev/snd/pcm* | head -n 1)
    if ! grep -q :${audioGroupId}: /etc/group; then
        groupadd --gid ${audioGroupId} audio_${user}
    fi
    audioGroup=$(stat -c %G /dev/snd/pcm* | head -n 1)
    if ! id -G ${user} | grep -qw ${audioGroupId}; then
        usermod -a -G ${audioGroupId} ${user}
    fi
fi
