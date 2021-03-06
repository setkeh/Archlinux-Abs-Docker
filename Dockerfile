#Dockerfile for Spinning up ABS Instances.
FROM base/archlinux:latest
MAINTAINER Setkeh "setkeh@gmail.com"

# This Shouldent be Needed for :Latest But Just to Be Sure
RUN pacman-key --init
RUN pacman-key --populate archlinux

# Now Lets Update
RUN pacman -Syu --noconfirm --ignore filesystem

# Install The Utils we need
RUN pacman -S zsh abs git --noconfirm

# Now Setup a User.
RUN useradd -m -d /home/docker -p docker docker

# Add Some Default Configs
RUN git clone https://github.com/setkeh/Docker-Home.git /tmp/home/
RUN cp -r /tmp/home/.vim/ /home/docker/.vim/
RUN cp -r /tmp/home/.vimrc /home/docker/.vimrc
RUN cp -r /tmp/home/.zshrc /home/docker.zshrc
RUN rm -rf /tmp/home/
RUN chsh -s /bin/zsh docker
RUN mkdir -p /home/docker/abs
RUN chown -R docker:users /home/docker

# Update ABS
RUN abs
