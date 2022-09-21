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

ADD https://chezmoi.io/get install_chezmoi.sh
RUN ["/bin/sh", "./install_chezmoi.sh", "-b", "/usr/local/bin"]

USER $USER
WORKDIR /home/$USER
RUN ["chezmoi", "init", "https://github.com/audioboxer217/my_dotfiles", "--branch=switch_to_chezmoi", "--apply"]

CMD ["/bin/bash"]
