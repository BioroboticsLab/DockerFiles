#! /usr/bin/env bash

CUDNN="cudnn-7.0-linux-x64-v3.0-prod.tgz"
if [ ! -e "$CUDNN" ]; then
    echo "Download CUDNN $CUDNN from the NVIDIA homepage and put it into this directory."
    exit 1
fi

docker build -t biorobotics/arch-python .