
@SETLOCAL
::@ECHO OFF
:: SET PATHS
SET "BASEDIR=%cd%"
:: fix the slash problem for ctest
:: https://stackoverflow.com/questions/23542453/change-backslash-to-forward-slash-in-windows-batch-file
SET "BASEDIR=%BASEDIR:\=/%"

SET TAG=%1
SET TAGDIR=devsim_msys_%1

:: start shell in anaconda environment with cmake installed

:: conda install numpy mkl tk for both python2 and python3 environments
SET DEVSIM_PY_LIB=%BASEDIR%/%TAGDIR%/lib

SET DEVSIM_PY37_BAT=%BASEDIR%/devsim_py37.bat
SET CMAKE_EXE=cmake
SET CTEST_EXE=ctest


:: rm -rf run && mkdir run
SET RELEASEDIR=%BASEDIR%/%TAGDIR%
SET RUNDIR=%RELEASEDIR%/run

if exist "%RUNDIR%" rmdir /s /q "%RUNDIR%"
mkdir "%RUNDIR%"

SET GOLDENDIR=%BASEDIR%/goldenresults

:: put the CMakeLists.txt in the right place
COPY "%BASEDIR%/CMakeLists.txt" "%RELEASEDIR%"

> %DEVSIM_PY37_BAT% (
@echo @echo off
echo @setlocal
echo SET MKL_NUM_THREADS=1
echo SET PYTHONPATH=%DEVSIM_PY_LIB%
echo SET PYTHONIOENCODING=utf-8
echo call python %%*
)

cd %RUNDIR%
%CMAKE_EXE% -DDEVSIM_TEST_GOLDENDIR=%GOLDENDIR% -DDEVSIM_PY3_TEST_EXE=%DEVSIM_PY37_BAT% %RELEASEDIR%
%CTEST_EXE% -j2
