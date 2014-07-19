#Dockerfile for Spinning up ABS Instances.
FROM base/archlinux:latest
MAINTAINER Setkeh "setkeh@gmail.com"

# This Shouldent be Needed for :Latest But Just to Be Sure
RUN pacman-key --init
RUN pacman-key --populate archlinux

# Now Lets Update
RUN pacman -Syu --noconfirm --ignore filesystem

# Install The Utils we need
RUN pacman -S zsh abs --noconfirm

# Now Setup a User.
RUN useradd -m -d /home/docker -p docker docker

# Add Some Default Configs
ADD home.tgz /tmp/home.tgz
RUN tar -xvf /tmp/home.tgz -C /home/docker
RUN cp -r /home/docker/home/. /home/docker/
RUN rm -rf /tmp/home.tgz
RUN rm -rf /home/docker/home
RUN chsh -s /bin/zsh docker
RUN mkdir -p /home/docker/abs
RUN chown -R docker:users /home/docker

# Update ABS
RUN abs
