#!/bin/sh

[ -d /opt/biorobotics-dev-environment/build/Release/biotracker_gui/biotracker ] && PATH=$PATH:/opt/biorobotics-dev-environment/build/Release/biotracker_gui/biotracker
[ -d /opt/biorobotics-dev-environment/build/Release/deeplocalizer_tagger/source/tagger ] && PATH=$PATH:/opt/biorobotics-dev-environment/build/Release/deeplocalizer_tagger/source/tagger
[ -d /opt/biorobotics-dev-environment/build/Release/parameteroptimization/parameteroptimization ] && PATH=$PATH:/opt/biorobotics-dev-environment/build/Release/parameteroptimization/parameteroptimization

export PATH
