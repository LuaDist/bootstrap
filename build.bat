@REM Builds LuaDist in MinGW (mingw32-make).
@echo OFF
setlocal

rem Edit paths to cmake\mingw if needed
set PATH=C:\CMake\bin\;C:\MinGW\bin\;%PATH%

set RELEASE=mingw
echo Bootstraping LuaDist (_bootstrap/%RELEASE%)
echo NOTE: Add -DCMAKE_BUILD_TYPE=Release when building release version.

mkdir "_bootstrap\%RELEASE%"
cd "_bootstrap\%RELEASE%"
cmake ..\.. -G "MinGW Makefiles" %*
cmake --build . --target install

endlocal
