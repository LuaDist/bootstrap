@REM Builds LuaDist using MinGW
@echo OFF

setlocal
rem Edit paths to cmake\mingw if needed
set PATH=C:\CMake\bin\;C:\MinGW\bin\;%PATH%

mkdir tmp/install && cd tmp/install
cmake ..\.. -G "MinGW Makefiles" -DCMAKE_INSTALL_PREFIX=..\.. -DDISTS="%*"
cmake --build . --target install
endlocal
