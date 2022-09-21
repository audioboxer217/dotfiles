# Test for my_dotfiles
#
# VERSION               1.0

FROM ubuntu:20.04

ARG USER=scott

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git curl wget sudo zip tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN useradd -ms /bin/bash $USER
RUN usermod -aG sudo $USER
RUN echo "$USER:changeme" | chpasswd
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD --chown=$USER --chmod=755 https://chezmoi.io/get /home/$USER/install_chezmoi.sh

USER $USER
WORKDIR /home/$USER
ADD --chown=$USER --chmod=755 . chezmoi
RUN ["/bin/sh", "./install_chezmoi.sh", "--", "init", "--source=chezmoi", "--apply"]

ENTRYPOINT ["/bin/bash"]
