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

export GYP_GENERATORS=ninja
cd angle
python scripts/bootstrap.py
gclient sync
ninja -C out/Release
cd ..

cp -rf angle/include/EGL/* include/EGL
cp -rf angle/include/KHR/* include/KHR
cp -rf angle/include/GLES2/* include/GLES2
cp -rf angle/include/GLES3/* include/GLES3