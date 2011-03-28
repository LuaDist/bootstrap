:: Copyright (C) 2011 LuaDist
:: Redistribution and use of this file is allowed according to the terms of the MIT license.
:: For details see the COPYRIGHT file distributed with LuaDist.
:: Please note that the package source code is licensed under its own license.

@echo off
setlocal
set REPO=%~dp0
set REPO=%REPO:~0,-1%
set DEPL=%CD%\_install

echo WARNING: This will build LuaDist two times!

cd "%REPO%" && git submodule update --init
mkdir "%DEPL%\tmp\install"
cd "%DEPL%\tmp\install" && cmake "%REPO%" -G"MinGW Makefiles" -DCMAKE_INSTALL_PREFIX="%DEPL%" cmake --build "%DEPL%\tmp\install" --target install
echo NOTE: If you received dependency error your build should be ok anyway. Update to CMake 2.8.4 to avoid this bug.

endlocal
