# Dockerfile
#
# Project: docker-ubuntu-x
# License: GNU GPLv3
#
# Copyright (C) 2016 Robert Cernansky



FROM ubuntu



MAINTAINER openhs
LABEL version = "0.0.0" \
      description = "Base Ubuntu image for X applications."



RUN /bin/echo -e \
      "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse\n \
       deb http://archive.ubuntu.com/ubuntu/ xenial-updates multiverse\n \
       deb http://archive.ubuntu.com/ubuntu/ xenial-security multiverse" >> \
         /etc/apt/sources.list && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    xauth

RUN useradd --shell /bin/false --create-home appuser

COPY setup_access_to_host_display.sh add_user_to_audio_group.sh \
     docker-ubuntu-x_startup.sh /opt/
RUN chmod +x /opt/setup_access_to_host_display.sh \
    /opt/add_user_to_audio_group.sh /opt/docker-ubuntu-x_startup.sh

ENTRYPOINT ["/opt/docker-ubuntu-x_startup.sh"]
