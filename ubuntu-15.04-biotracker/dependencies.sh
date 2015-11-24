#!/bin/bash
# FU Biorobotics lab:
# Dependencies for BioTracker

# BUILD deps
apt-get update && apt-get install -y \
    git \
    apt-utils \
    build-essential \
    libgtk2.0-dev \
    cmake \
    cmake-gui \
    mesa-common-dev \
    libglu1-mesa-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    qt5-default \
    libopencv-dev \
    libc++abi-dev
#    libboost-all-dev \

cd /usr/local
wget http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.bz2
tar --bzip2 -xf boost_1_59_0.tar.bz2
rm boost_1_59_0.tar.bz2
cd boost_1_59_0
./bootstrap.sh
./b2 install

# PYTHON deps
apt-get install -y python-dev
apt-get install -y python3-dev
apt-get install -y python-numpy
apt-get install -y python3-numpy
apt-get install -y python3-setuptools
apt-get install -y astyle
easy_install3 pip

apt-get install -y --no-install-recommends doxygen

# ZMQ deps
apt-get install -y libzmq-dev
pip install pyzmq

apt-get install -y python-zmq
