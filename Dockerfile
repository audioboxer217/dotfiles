# Test for my_dotfiles
#
# VERSION               1.0
#checkov:skip=CKV_DOCKER_2: required

FROM ubuntu:20.04

ARG USER=scott

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git curl wget sudo zip tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
    #checkov:skip=CKV2_DOCKER_1: required

RUN useradd -ms /bin/bash $USER && \
    usermod -aG sudo $USER
#checkov:skip=CKV2_DOCKER_1: required
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "$USER:changeme" | chpasswd
#checkov:skip=CKV2_DOCKER_17: required
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#checkov:skip=CKV_DOCKER_4: required
ADD --chown=$USER --chmod=755 https://chezmoi.io/get /home/$USER/install_chezmoi.sh

USER $USER
WORKDIR /home/$USER
COPY --chown=$USER --chmod=755 . chezmoi
RUN ["/bin/sh", "./install_chezmoi.sh", "--", "init", "--source=chezmoi", "--apply"]

ENTRYPOINT ["/bin/bash"]
