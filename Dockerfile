# Test for my_dotfiles
#
# VERSION               0.2

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

COPY --chown=$USER . /home/$USER/dotfiles
USER $USER
WORKDIR /home/$USER/dotfiles
RUN ["/bin/bash", "./setup_home.sh"]
RUN ["/bin/bash", "./run_tests.sh"]

CMD ["/bin/bash"]
