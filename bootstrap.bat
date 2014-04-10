:: WARNING: This script assumes CMake 2.8.4+ and GCC/MinGW compiler is installed and available in system PATH.
:: Copyright (C) 2013 LuaDist
:: Redistribution and use of this file is allowed according to the terms of the MIT license.
:: For details see the COPYRIGHT file distributed with LuaDist.
:: Please note that the package source code is licensed under its own license.

@echo off
setlocal
set REPO=%~dp0
set REPO=%REPO:~0,-1%

set BOOT=%REPO%\_bootstrap
set BUILD=%BOOT%\tmp
set LUADIST=%BOOT%\bin\luadist.exe
set INSTALL=%REPO%\_install

echo ## This will build some LuaDist components TWO times!

mkdir "%BUILD%"
cd "%BUILD%" && cmake "%REPO%" -G"MinGW Makefiles" -DCMAKE_INSTALL_PREFIX="%BOOT%"
cmake --build "%BUILD%" --target install

echo ## Bootstrap done, building LuaDist using LuaDist

set LUA_PATH=
set LUA_CPATH=
set LUA_PATH_5_2=
set LUA_CPATH_5_2=
%LUADIST% "%INSTALL%" install luadist-git -binary=false -source %*

echo ## LuaDist is now built and can be found in %INSTALL%

endlocal
