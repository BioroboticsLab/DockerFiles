FROM pytorch-cudnnv5
MAINTAINER github@leon-sixt.de

RUN apt-get update && apt-get install -y --assume-yes --install-recommends \
        python \
        python-dev \
        python3 \
        python3-dev \
        python3-six \
        python3-tz \
        python3-babel \
        python3-roman \
        python3-docutils \
        python3-markupsafe \
        python3-jinja2 \
        python3-numpy \
        python3-pygments \
        checkinstall \
        git \
        build-essential \
        g++-4.9 \
        g++ \
        cmake \
        wget \
        libopenblas-dev \
        libavformat-dev \
        libavcodec-dev \
        libavdevice-dev \
        libavutil-dev \
        libswscale-dev \
        libavresample-dev \
        libavcodec-extra \
        libav-tools \
        qtbase5-dev \
        pkg-config \
        libbz2-dev \
        python3-scipy \
        python3-setuptools \
        python3-pip \
        python3-nose \
        python3-pytest \
        python3-sklearn \
        python3-skimage \
        python3-h5py \
        python3-matplotlib \
        python3-seaborn \
        python3-cairocffi \
        tmux \
        gdb \
        capnproto \
        vim \
        vim-nox \
        libgflags-dev \
        libzmqpp-dev \
        libhdf5-dev \
        libhdf5-cpp-11 \
        hdf5-tools \
        libgoogle-glog-dev \
        jq \
        sshfs \
        zsh && \
    rm -rf /var/lib/apt/lists

RUN pip3 install \
    Theano \
    keras \
    jupyter \
    xgboost \
    pytest-cov \
    pytest-benchmark \
    pytest-flake8 \
    shyaml \
    more_itertools \
    scikit-image \
    click \
    pandas

RUN ldconfig    # otherwise the cuda libaries are not found

RUN locale-gen en_US.UTF-8  # fix utf-8 encoding
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Use the same gid and uid as your user on the host system. You can find them
# out with the `id`  programm. This way the file ownership in mapped directories is
# consistent with the host system.
#
RUN groupadd --gid $UID $USER
RUN useradd --uid $UID  --gid $USER \
    --home-dir /home/$USER --shell /usr/bin/zsh  \
    --groups sudo,$USER \
    --password $USER \
    $USER

# default password $USER
RUN echo $USER:$PASSWORD | chpasswd && \
    echo root:$PASSWORD | chpasswd

USER $USER
WORKDIR /home/$USER
