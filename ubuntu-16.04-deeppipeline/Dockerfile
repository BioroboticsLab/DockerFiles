FROM nvidia/cuda:cudnn-devel-ubuntu16.04
MAINTAINER Benjamin Wild <b.w@fu-berlin.de>

RUN apt-get update && apt-get install -y --assume-yes --install-recommends \
        python3-numpy \
        python3-scipy \
        python3-dev \
        python3-setuptools \
        python3-pip \
        python3-nose \
        python3-sklearn \
        python3-skimage \
        python3-pandas \
        python3-h5py \
        python3-matplotlib \
        python3-seaborn \
        python-dev \
        libavformat-dev \
        libavcodec-dev \
        libavdevice-dev \
        libavutil-dev \
        libswscale-dev \
        libavresample-dev \
        tmux \
        qtbase5-dev \
        pkg-config \
        capnproto \
        build-essential \
        checkinstall \
        cmake \
        g++ \
        wget \
        libbz2-dev \
        libopenblas-dev \
        git \
        vim \
        vim-nox \
        libgflags-dev \
        libzmqpp-dev \
        zsh && \
    rm -rf /var/lib/apt/lists


RUN apt-get update && apt-get build-dep -y --assume-yes --no-install-recommends \
        libopencv-dev && \
    rm -rf /var/lib/apt/lists

RUN mkdir -p /tmp/source && \
    cd /tmp/source && \
    git clone --branch 3.1.0 --depth 1 https://github.com/Itseez/opencv.git && \
    mkdir -p /tmp/build/opencv && \
    cd /tmp/build/opencv && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=/usr/ \
          -DWITH_CUDA=OFF \
          -DWITH_CUFFT=OFF \
          -DWITH_CUBLAS=OFF \
          -DBUILD_opencv_java=OFF \
          -DBUILD_TESTS=OFF \
          -DBUILD_PERF_TESTS=OFF \
          -DBUILD_EXAMPLES=OFF \
          /tmp/source/opencv && \
    make -j `nproc`
RUN cd /tmp/build/opencv && checkinstall


RUN cd /tmp/source && \
    wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2/download?use_mirror=netcologne -O boost.tar.bz2 && \
    tar -xf boost.tar.bz2 && \
    ls && \
    cd boost_1_61_0 && \
    ls && \
    ./bootstrap.sh --prefix=/usr --with-python=/usr/bin/python3

RUN cd /tmp/source/boost_1_61_0 && \
    ./b2 -j `nproc` install

RUN pip3 install --no-deps Theano keras==1.0.3 jupyter xgboost
