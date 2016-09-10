#! /usr/bin/env bash

# sshfs_mount.sh [USERNAME]
#
# Mounts /mnt/storage /home/beesbook from flip with sshfs
#

MOUNT_POINTS="/mnt/storage /home/beesbook"

if [ "$1" == "" ]; then
    USER=`whoami`
else
    USER="$1"
fi

echo "su - root -c \"mkdir -p $MOUNT_POINTS && chmod o+rwx $MOUNT_POINTS\""
su - root -c "mkdir -p $MOUNT_POINTS; chmod o+rwx $MOUNT_POINTS"

echo sshfs $USER@flip:/mnt/storage /mnt/storage
sshfs $USER@flip:/mnt/storage /mnt/storage

echo sshfs $USER@flip:/home/beesbook /home/beesbook
sshfs $USER@flip:/home/beesbook /home/beesbook
