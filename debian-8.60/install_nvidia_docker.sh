#! /usr/bin/env bash


# install docker from: https://docs.docker.com/engine/installation/linux/debian/#/debian-jessie-80-64-bit
apt-get purge "lxc-docker*"
apt-get purge "docker.io*"


apt-get update
apt-get install apt-transport-https ca-certificates

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo debian-jessie main" > \
    /etc/apt/sources.list.d/docker.list


apt-get update
apt-get install docker-engine

groupadd docker

# install nvidia docker: https://github.com/NVIDIA/nvidia-docker/wiki
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.0-rc.3/nvidia-docker_1.0.0.rc.3-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb
