@echo off

setlocal

set SELF=%~dp0

set BUILD_DIR=c:/build/rscpp_usd_test
if not exist "%BUILD_DIR%" mkdir %BUILD_DIR%
cd %BUILD_DIR%

"C:/Program Files/CMake/bin/cmake.exe" %* ^
-G"Visual Studio 15 2017 Win64" ^
%SELF%

endlocal
