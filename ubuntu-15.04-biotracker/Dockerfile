# This dockerfile is used to run the biotracker

FROM bioroboticslab/ubuntu-15.04-jenkins-slave
Maintainer Michael Wittig <witmic1@gmail.com>

# install all dependencies
RUN apt-get update && apt-get install -y \
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
    libc++abi-dev && \
    python-dev \
    python3-dev \
    python-numpy \
    python3-numpy \
    python3-setuptools \
    libzmq-dev \
    astyle && \
    apt-get install -y --no-install-recommends doxygen && \
    easy_install3 pip && \
    pip install pyzmq && \
    mkdir -p /home/jenkins/scripts

COPY build-biotracker.sh /home/jenkins/scripts/build-biotracker.sh
RUN chmod +x /home/jenkins/scripts/build-biotracker.sh; chown -R jenkins:jenkins /home/jenkins/scripts
