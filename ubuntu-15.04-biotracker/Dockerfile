# This dockerfile is used to run the biotracker

FROM biotracker/ubuntu-15.04-slave
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
    libc++abi-dev

# install doxygen
RUN apt-get install -y --no-install-recommends doxygen

# install python
RUN apt-get install -y python-dev python3-dev

# Switch to jenkins and setup environment
RUN mkdir -p /home/jenkins/scripts
COPY build-biotracker.sh /home/jenkins/scripts/build-biotracker.sh
RUN chmod +x /home/jenkins/scripts/build-biotracker.sh; chown -R jenkins:jenkins /home/jenkins/scripts
