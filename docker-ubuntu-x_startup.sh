#!/bin/bash

# docker-ubuntu-x_startup.sh
#
# Startup script for the container.
#
# Project: docker-ubuntu-x
# License: GNU GPLv3
#
# Copyright (C) 2016 Robert Cernansky



USER=appuser



if [ "-h" == "${1}" ] || [ "--help" == "${1}" ]; then
    cat <<EOF
Usage:
  docker -e DISPLAY=\${DISPLAY} [--device /dev/<sound_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix -v \${XAUTHORITY}:${HOST_XAUTHORITY}:ro openhs/ubuntu-x [app]

  Devices for an Alsa sound card:
    /dev/snd
  or
    /dev/snd/controlC0, /dev/snd/pcmC0D0p
EOF
  exit 0
fi

application=${1:-/bin/bash}
shift

echo "adding authorization token for X server"
/opt/setup_access_to_host_display.sh ${USER}

/opt/add_user_to_audio_group.sh ${USER}

applicationWithArguments="${application} ${@}"
echo "starting the application ${applicationWithArguments}"
su - --shell /bin/sh --command "${applicationWithArguments}" ${USER}
