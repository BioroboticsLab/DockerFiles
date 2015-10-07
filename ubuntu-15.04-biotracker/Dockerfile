# This dockerfile is used to run the biotracker

FROM sh4ke/ubuntu-15.04-jenkins-slave
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
COPY setup-biorobotics-dev-environment.sh /home/jenkins/scripts/setup-biorobotics-dev-environment.sh
RUN chmod +x /home/jenkins/scripts/setup-biorobotics-dev-environment.sh; chown -R jenkins:jenkins /home/jenkins/scripts

User jenkins
WORKDIR /home/jenkins
CMD bash -c "~/scripts/setup-biorobotics-dev-environment.sh"
