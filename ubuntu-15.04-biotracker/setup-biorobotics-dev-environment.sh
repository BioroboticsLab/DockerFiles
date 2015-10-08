#!/bin/sh

CURRENT_DIR=`pwd`
ROOT_DIR=$CURRENT_DIR/biorobotics-dev-environment
SRC_DIR=$ROOT_DIR/source
NUM_CORES=`nproc`
NUM_THREADS=$(($NUM_CORES + 1))
# URL_PREFIX="git@github.com:"
URL_PREFIX="https://github.com/"

set -e

if [ -d "$ROOT_DIR" ]; then
    echo 'Folder already exists.'
    exit
fi
if [ -z "$@" ]; then
    BUILD_TYPES="Debug RelWithDebInfo Release"
else
    BUILD_TYPES="$@"
fi

mkdir -p $SRC_DIR

git clone ${URL_PREFIX}BioroboticsLab/biotracker_core.git $SRC_DIR/biotracker_core
git clone ${URL_PREFIX}BioroboticsLab/biotracker_gui.git $SRC_DIR/biotracker_gui

print_message() {
    echo "##############################################################"
    echo "Build project: $1"
    echo "Build type: $2"
    echo "Build directory: $3"
    echo "##############################################################"
}

for BUILD_TYPE in $BUILD_TYPES; do
        BUILD_DIR=$ROOT_DIR/build/$BUILD_TYPE

        mkdir -p $BUILD_DIR

        mkdir -p $BUILD_DIR/biotracker_core
        cd $BUILD_DIR/biotracker_core
        print_message "biotracker_core" $BUILD_TYPE `pwd`
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE $SRC_DIR/biotracker_core -DBIOTRACKER_BUILD_TESTS=ON
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/biotracker_gui
        cd $BUILD_DIR/biotracker_gui
        print_message "biotracker_gui" $BUILD_TYPE `pwd`
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBIOTRACKER_CORE_PATH=$SRC_DIR/biotracker_core $SRC_DIR/biotracker_gui
        make -j $NUM_THREADS
done
