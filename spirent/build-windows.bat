@echo on

REM Builds the nghttp2 for STC for all Windows 64bit platform configurations.
REM NOTICE: Follow instructions and change a few variables below before building.

REM Change STC_ROOT to the STC build root folder.
set STC_ROOT=%STC_BUILD_ROOT%
@echo %STC_ROOT%
IF "%STC_ROOT%" == "" (
  set STC_ROOT=D:\table\blds\bandrews\bld
)

pushd C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Tools
call VsDevCmd.bat -arch=x64
popd

@echo --------------------------------- BUILDING Win64 Release ----------------------------------

cmake . -A x64 -DCMAKE_BUILD_TYPE=Release -DENABLE_STATIC_LIB:BOOL="1"
cmake --build . --config Release --clean-first


@echo --------------------------------- BUILDING Win64 Debug ----------------------------------

set BOOST_LIBRARYDIR=%BOOST_LIB_WIN64_DEBUG%

cmake . -A x64 -DCMAKE_BUILD_TYPE=Debug -DENABLE_STATIC_LIB:BOOL="1"
cmake --build . --config Debug --clean-first

@echo --------------------------------- BUILDING nghttp2 completed ----------------------------------
