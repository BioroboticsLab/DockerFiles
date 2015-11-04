FROM biorobotics/arch
MAINTAINER github@leon-sixt.de

RUN pacman -S --noconfirm \
    python \
    python-pip \
    python-setuptools \
    python-numpy \
    python-scipy \
    python-pillow \
    jupyter \
    ipython-notebook \
    mathjax

RUN pip install -r https://raw.githubusercontent.com/Lasagne/Lasagne/master/requirements.txt
RUN pip install keras==0.1.3 \
    scikit-learn \
    scikit-image

ENV CUDA_ROOT=/opt/cuda
ENV THEANO_FLAGS='cuda.root=/opt/cuda,device=gpu,floatX=float32'
# ADD extracts files to /opt/cuda
ADD cudnn-7.0-linux-x64-v3.0-prod.tgz /opt/