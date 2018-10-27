
@SETLOCAL
::@ECHO OFF
:: SET PATHS
SET "BASEDIR=%cd%"
:: fix the slash problem for ctest
:: https://stackoverflow.com/questions/23542453/change-backslash-to-forward-slash-in-windows-batch-file
SET "BASEDIR=%BASEDIR:\=/%"

SET TAG=%1
SET TAGDIR=devsim_win64_%1

:: start shell in anaconda environment with cmake installed
SET ANACONDAPATH=%USERPROFILE%/Miniconda2/envs

:: conda install numpy mkl tk for both python2 and python3 environments
SET DEVSIM_PY_LIB=%BASEDIR%/%TAGDIR%/lib
SET DEVSIM_TCL_EXE=%BASEDIR%/%TAGDIR%/bin/devsim_tcl

SET DEVSIM_PY27_BAT=%BASEDIR%/devsim_py27.bat
SET DEVSIM_PY37_BAT=%BASEDIR%/devsim_py37.bat
SET DEVSIM_TCL_BAT=%BASEDIR%/devsim_tcl.bat
SET CMAKE_EXE=%ANACONDAPATH%/python27/Library/bin/cmake
SET CTEST_EXE=%ANACONDAPATH%/python27/Library/bin/ctest


:: rm -rf run && mkdir run
SET RELEASEDIR=%BASEDIR%/%TAGDIR%
SET RUNDIR=%RELEASEDIR%/run

if exist "%RUNDIR%" rmdir /s /q "%RUNDIR%"
mkdir "%RUNDIR%"

SET GOLDENDIR=%BASEDIR%/goldenresults

:: put the CMakeLists.txt in the right place
COPY "%BASEDIR%/CMakeLists.txt" "%RELEASEDIR%"

> %DEVSIM_PY27_BAT% (
@echo @echo off
echo @setlocal
echo SET MKL_NUM_THREADS=1
echo call conda activate python27
echo SET PYTHONPATH=%DEVSIM_PY_LIB%
echo call python %%*
)


> %DEVSIM_PY37_BAT% (
@echo @echo off
echo @setlocal
echo SET MKL_NUM_THREADS=1
echo call conda activate python37
echo SET PYTHONPATH=%DEVSIM_PY_LIB%
echo SET PYTHONIOENCODING=utf-8
echo call python %%*
)

> %DEVSIM_TCL_BAT% (
@echo @echo off
echo @setlocal
echo SET MKL_NUM_THREADS=1
echo call conda activate python27
echo call %DEVSIM_TCL_EXE% %%*
)

cd %RUNDIR%
%CMAKE_EXE% -DDEVSIM_TEST_GOLDENDIR=%GOLDENDIR% -DDEVSIM_PY2_TEST_EXE=%DEVSIM_PY27_BAT% -DDEVSIM_PY3_TEST_EXE=%DEVSIM_PY37_BAT% -DDEVSIM_TCL_TEST_EXE=%DEVSIM_TCL_BAT% %RELEASEDIR%
%CTEST_EXE% -j2
