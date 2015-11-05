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
    libboost-all-dev \
    libc++abi-dev

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
