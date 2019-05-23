#!/bin/sh
export PATH=${PWD}/depot_tools:$PATH

#ERROR=$?

virtualenv --python=/usr/bin/python2 python2
source python2/bin/activate  

cd angle
python scripts/bootstrap.py
gclient sync
git checkout master
./build/install-build-deps.sh
gn gen out/Release "--args=is_debug=false target_cpu=\"x64\" is_clang=false use_sysroot=false"
ninja -C out/Release
cd ..

mkdir -p include/EGL
mkdir -p include/KHR
mkdir -p include/GLES2
mkdir -p include/GLES3
cp -rf angle/include/EGL/* include/EGL
cp -rf angle/include/KHR/* include/KHR
cp -rf angle/include/GLES2/* include/GLES2
cp -rf angle/include/GLES3/* include/GLES3

mkdir -p lib
cp -f angle/out/Release/lib/libEGL.so lib
cp -f angle/out/Release/lib/libGLESv2.so lib
cp -f angle/out/Release/libEGL.dylib lib
cp -f angle/out/Release/libGLESv2.dylib lib
ls lib

#echo $ERROR