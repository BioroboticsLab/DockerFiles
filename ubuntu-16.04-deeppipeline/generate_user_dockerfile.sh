#! /usr/bin/env bash

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -u|--user)
    USER="$2"
    shift # past argument
    ;;
    --uid)
    UID="$2"
    shift # past argument
    ;;
    -p|--password)
    PASSWORD="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

echo $USER
echo $UID
echo $PASSWORD
if [ "$PASSWORD" == "" ]; then
    PASSWORD="$USER"
fi


OUT_DIR="$USER-deeppipeline"
mkdir -p  "$OUT_DIR"

cat <<EOF  > $OUT_DIR/Dockerfile
FROM deeppipeline/ubuntu-16.04
MAINTAINER github@leon-sixt.de

# setup sudo
# RUN groupadd --system sudo
# RUN echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers

# Use the same gid and uid as your user on the host system. You can find them
# out with the `id`  programm. This way the file ownership in mapped directories is
# consistent with the host system.
#
RUN groupadd --gid $UID $USER
RUN useradd --uid $UID  --gid $USER \
    --home-dir /home/$USER --shell /usr/bin/zsh  \
    --groups sudo,$USER \
    --password leon \
    leon

# default password leon
RUN echo leon:$PASSWORD | chpasswd && \
    echo root:$PASSWORD | chpasswd

USER leon
WORKDIR /home/leon
EOF
