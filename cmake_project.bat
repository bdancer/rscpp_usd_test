:: V-Ray For USD Visual Studio solution
::
@echo off

setlocal

set SELF=%~dp0

:: For Visual Studio
set VSCMD_START_DIR=%CD%

:: For Qt CMake
set CMAKE_PREFIX_PATH=C:/programs/qt/5.10.1/msvc2017_64

set SDK_ROOT=C:/src/vray_for_houdini_sdk_windows

set HOUDINI_VERSION=18.0
set HOUDINI_VERSION_BUILD=391

set BUILD_DIR=c:/build/rscpp_usd_test
if not exist "%BUILD_DIR%" mkdir %BUILD_DIR%
cd %BUILD_DIR%

"C:/Program Files/CMake/bin/cmake.exe" %* ^
-G"Visual Studio 15 2017 Win64" ^
-DSDK_PATH=%SDK_ROOT% ^
-DAPPSDK_ROOT=%SDK_ROOT%/appsdk/master/4.30 ^
-DHOUDINI_INSTALL_ROOT="C:/Program Files/Side Effects Software/Houdini %HOUDINI_VERSION%.%HOUDINI_VERSION_BUILD%" ^
-DHOUDINI_VERSION=%HOUDINI_VERSION% ^
-DHOUDINI_VERSION_BUILD=%HOUDINI_VERSION_BUILD% ^
%SELF%

endlocal
