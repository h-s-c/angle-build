#!/bin/sh
export PATH=${PWD}/depot_tools:$PATH
export GYP_GENERATORS=ninja
export GYP_PARALLEL=1

cd angle
python scripts/bootstrap.py
gclient sync
ninja -C out/Release
ls out/Release
ls out/Release/lib
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
cp -f angle/out/Release/lib/libEGL.dylib lib
cp -f angle/out/Release/lib/libGLESv2.dylib lib
ls lib