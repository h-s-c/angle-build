set PATH=%PATH%;%CD%\depot_tools
set GYP_GENERATORS=msvs

cd angle
python scripts/bootstrap.py
gclient sync
msbuild samples\samples.sln /p:Configuration=Release /p:Platform="x64"
cd ..

xcopy /E /I angle\include\EGL include\EGL
xcopy /E /I angle\include\KHR include\KHR
xcopy /E /I angle\include\GLES2 include\GLES2
xcopy /E /I angle\include\GLES3 include\GLES3

if exist lib rd /s /q lib
mkdir lib
copy angle\samples\Release_x64\lib\libEGL.lib lib\libEGL.lib
copy angle\samples\Release_x64\lib\libGLESv2.lib lib\libGLESv2.lib
copy angle\samples\Release_x64\libEGL.dll lib\libEGL.dll
copy angle\samples\Release_x64\libGLESv2.dll lib\libGLESv2.dll
copy angle\samples\Release_x64\d3dcompiler_47.dll lib\d3dcompiler_47.dll
dir lib