set PATH=%PATH%;%CD%\depot_tools
set GYP_GENERATORS=ninja
set GYP_PARALLEL=1

cd angle
python scripts/bootstrap.py
call gclient sync
ninja -C out\Release
cd ..

xcopy /E /I angle\include\EGL include\EGL
xcopy /E /I angle\include\KHR include\KHR
xcopy /E /I angle\include\GLES2 include\GLES2
xcopy /E /I angle\include\GLES3 include\GLES3

if exist lib rd /s /q lib
mkdir lib
copy angle\out\Release\libEGL.dll.lib lib\libEGL.lib
copy angle\out\Release\libGLESv2.dll.lib lib\libGLESv2.lib
copy angle\out\Release\libEGL.dll lib\libEGL.dll
copy angle\out\Release\libGLESv2.dll lib\libGLESv2.dll
copy angle\out\Release\d3dcompiler_47.dll lib\d3dcompiler_47.dll
dir lib