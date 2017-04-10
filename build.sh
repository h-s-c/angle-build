#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists virtualenv2 ; then
    virtualenv2 python2
else
    virtualenv python2
fi

source python2/bin/activate
python --version

git submodule update --init --recursive
export PATH=${PWD}/depot_tools:$PATH

export GYP_GENERATORS=msvs
cd angle
python scripts/bootstrap.py
gclient sync
ninja -C out/Release
cd ..