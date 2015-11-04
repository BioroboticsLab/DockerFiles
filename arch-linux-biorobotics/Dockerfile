FROM base/archlinux
RUN pacman-key --init && pacman-key --populate archlinux && pacman-key --refresh-keys
RUN pacman -Sy --noconfirm && \
    pacman -S openssl pacman --noconfirm && \
    pacman-db-upgrade
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
    base-devel \
    gcc \
    clang \
    cuda \
    nvidia \
    nvidia-libgl \
    python \
    leveldb \
    lmdb \
    git \
    cmake \
    qt5-base \
    qt5-3d \
    protobuf \
    boost \
    hdf5 \
    opencv \
    yajl \
    gcc-fortran \
    automake \
    google-glog \
    gflags \
    snappy \
    vim \
    htop \
    wget \
    tmux \
    zsh

RUN groupadd -r yaourt
RUN useradd -r -G wheel -g yaourt yaourt
RUN mkdir /tmp/yaourt
RUN chown -R yaourt:yaourt /tmp/yaourt

# install package-query
USER yaourt
WORKDIR /tmp/yaourt
RUN curl https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz | tar zx
WORKDIR /tmp/yaourt/package-query
RUN makepkg --noconfirm
USER root
WORKDIR /tmp/yaourt/package-query
RUN pacman --noconfirm -U *.tar.xz

# install yaourt
USER yaourt
WORKDIR /tmp/yaourt
RUN curl https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz | tar zx
WORKDIR /tmp/yaourt/yaourt
RUN makepkg --noconfirm
USER root
WORKDIR /tmp/yaourt/yaourt
RUN pacman --noconfirm -U *.tar.xz

# install openblas-lapack
USER yaourt
RUN cd /tmp/yaourt && pwd && ls -al && ( yaourt --getpkgbuild openblas-lapack || true ) && cd openblas-lapack && makepkg --pkg  openblas-lapack
USER root
WORKDIR /tmp/yaourt/openblas-lapack
RUN pacman --noconfirm -U *.tar.xz

ENV PATH=$PATH:/opt/cuda/bin

# ADD extracts files to /opt/cuda
ADD cudnn-7.0-linux-x64-v3.0-prod.tgz /opt/

COPY build_caffe.sh /usr/bin/build_caffe.sh
RUN chmod +x /usr/bin/build_caffe.sh
WORKDIR /opt
RUN build_caffe.sh

COPY setup-biorobotics-dev-environment.sh /usr/bin/setup-biorobotics-dev-environment.sh
RUN chmod +x /usr/bin/setup-biorobotics-dev-environment.sh

COPY bioroboticsbin.sh /etc/profile.d/bioroboticsbin.sh
RUN chmod +x /etc/profile.d/bioroboticsbin.sh

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
