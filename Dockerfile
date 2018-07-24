# Dockerfile
#
# Project: docker-ubuntu-x
# License: GNU GPLv3
#
# Copyright (C) 2016 - 2018 Robert Cernansky



FROM ubuntu



MAINTAINER openhs
LABEL version = "0.0.1" \
      description = "Base Ubuntu image for X applications."



RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    xauth

RUN useradd --shell /bin/false --create-home appuser

COPY setup_access_to_host_display.sh add_user_to_audio_group.sh \
     docker-ubuntu-x_startup.sh /opt/
RUN chmod +x /opt/setup_access_to_host_display.sh \
    /opt/add_user_to_audio_group.sh /opt/docker-ubuntu-x_startup.sh

ENTRYPOINT ["/opt/docker-ubuntu-x_startup.sh"]
