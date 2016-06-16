#!/bin/bash

# setup_access_to_host_display.sh
#
# Sets up Xauthority file to access the host display.
#
# Project: docker-ubuntu-x
# License: GNU GPLv3
#
# Copyright (C) 2016 Robert Cernansky



HOST_XAUTHORITY=/tmp/.host_Xauthority



if [ "-h" == "$1" ] || [ "--help" == "$1" ] || [ -z $1 ] || [ "" == "$1" ]; then
    cat <<EOF
Usage:
  ${0} <user>
EOF
  exit 0
fi



user=${1}
containerXauthority=/home/${user}/.Xauthority

touch ${containerXauthority}
xauth -f ${containerXauthority} add ${DISPLAY} . $(xauth -f ${HOST_XAUTHORITY} list | grep "${DISPLAY} " | tail -n 1 \
  | cut -d " " -f 5)
chown ${user}:${user} ${containerXauthority}
