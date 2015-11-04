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

git clone ${URL_PREFIX}BioroboticsLab/cpm_caffe.git $SRC_DIR/cpm_caffe
git clone ${URL_PREFIX}BioroboticsLab/biotracker_core.git $SRC_DIR/biotracker_core
git clone ${URL_PREFIX}BioroboticsLab/biotracker_gui.git $SRC_DIR/biotracker_gui
git clone ${URL_PREFIX}BioroboticsLab/deeplocalizer_classifier.git $SRC_DIR/deeplocalizer_classifier
git clone ${URL_PREFIX}BioroboticsLab/pipeline.git $SRC_DIR/pipeline
git clone ${URL_PREFIX}BioroboticsLab/deeplocalizer_tagger.git $SRC_DIR/deeplocalizer_tagger
git clone ${URL_PREFIX}BioroboticsLab/parameteroptimization.git $SRC_DIR/parameteroptimization
git clone ${URL_PREFIX}BioroboticsLab/deeplocalizer_models.git $SRC_DIR/deeplocalizer_models
git clone ${URL_PREFIX}BioroboticsLab/bb_imageanalysis.git $SRC_DIR/bb_imageanalysis

cd $SRC_DIR/deeplocalizer_classifier
git checkout cpm

cd $SRC_DIR/deeplocalizer_classifier
git checkout cpm

cd $SRC_DIR/pipeline
git checkout cpm

function print_message() {
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
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE $SRC_DIR/biotracker_core
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/biotracker_gui
        cd $BUILD_DIR/biotracker_gui
        print_message "biotracker_gui" $BUILD_TYPE `pwd`
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBIOTRACKER_CORE_PATH=$SRC_DIR/biotracker_core $SRC_DIR/biotracker_gui
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/deeplocalizer_classifier
        cd $BUILD_DIR/deeplocalizer_classifier
        print_message "deeplocalizer_classifier" $BUILD_TYPE `pwd`
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBLAS=Open DCAFFE_PATH=$SRC_DIR/cpm_caffe -DBUILD_SHARED_LIBS=On $SRC_DIR/deeplocalizer_classifier
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/deeplocalizer_tagger
        cd $BUILD_DIR/deeplocalizer_tagger
        print_message "deeplocalizer_tagger" $BUILD_TYPE `pwd`
        cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -Wno-dev -DCPU_ONLY=On -DBLAS=Open -DCAFFE_PATH=$SRC_DIR/cpm_caffe -DDEEPLOCALIZER_CLASSIFIER_PATH=$SRC_DIR/deeplocalizer_classifier -DPIPELINE_PATH=$SRC_DIR/pipeline $SRC_DIR/deeplocalizer_tagger
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/pipeline
        cd $BUILD_DIR/pipeline
        print_message "pipeline" $BUILD_TYPE `pwd`
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DDEEPLOCALIZER_CLASSIFIER_PATH=$SRC_DIR/deeplocalizer_classifier -DBLAS=Open -DBUILD_SHARED_LIBS=On -DCAFFE_PATH=$SRC_DIR/cpm_caffe $SRC_DIR/pipeline
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/parameteroptimization
        cd $BUILD_DIR/parameteroptimization
        print_message "parameteroptimization" $BUILD_TYPE `pwd`
        cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE -Wno-dev -DCPU_ONLY=On -DBLAS=Open -DCAFFE_PATH=$SRC_DIR/cpm_caffe -DDEEPLOCALIZER_CLASSIFIER_PATH=$SRC_DIR/deeplocalizer_classifier -DPIPELINE_PATH=$SRC_DIR/pipeline -DBIOTRACKER_CORE_PATH=$SRC_DIR/biotracker_core -DBAYESOPT_BUILD_SHARED=On -DBIOTRACKER_BUILD_TESTS=Off -DBUILD_python=Off -BUILD_python_layer=Off -DBUILD_SHARED_LIBS=On -DDEEPLOCALIZER_MODELS_PATH=$SRC_DIR/deeplocalizer_models $SRC_DIR/parameteroptimization
        make -j $NUM_THREADS

        mkdir -p $BUILD_DIR/bb_imageanalysis
        cd $BUILD_DIR/bb_imageanalysis
        print_message "bb_imageanalysis" $BUILD_TYPE `pwd`
        cmake -Wno-dev -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DPIPELINE_PATH=$SRC_DIR/pipeline -DDEEPLOCALIZER_CLASSIFIER_PATH=$SRC_DIR/deeplocalizer_classifier -DCAFFE_PATH=$SRC_DIR/cpm_caffe $SRC_DIR/bb_imageanalysis
        make -j $NUM_THREADS
done
