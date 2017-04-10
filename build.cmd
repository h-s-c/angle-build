set PATH=%PATH%;%CD%\depot_tools
set GYP_GENERATORS=ninja

cd angle
python scripts/bootstrap.py
gclient sync
ninja -C out/Release
cd ..

xcopy /E /I %CD%\angle\include\EGL %CD%\include\EGL
xcopy /E /I %CD%\angle\include\KHR %CD%\include\KHR
xcopy /E /I %CD%\angle\include\GLES2 %CD%\include\GLES2
xcopy /E /I %CD%\angle\include\GLES3 %CD%\include\GLES3

if exist lib rd /s /q lib
mkdir lib
copy %CD%\angle\out\Release\lib\libGLESv2.lib %CD%\lib\libGLESv2.lib
copy %CD%\angle\out\Release\libEGL.dll %CD%\lib\libEGL.dll
copy %CD%\angle\out\Release\libGLESv2.dll %CD%\lib\libGLESv2.dll
copy %CD%\angle\out\Release\d3dcompiler_47.dll %CD%\lib\d3dcompiler_47.dll
dir lib