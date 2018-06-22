
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
SET DEVSIM_PY_EXE=%BASEDIR%/%TAGDIR%/bin/devsim
SET DEVSIM_PY3_EXE=%BASEDIR%/%TAGDIR%/bin/devsim_py3
SET DEVSIM_TCL_EXE=%BASEDIR%/%TAGDIR%/bin/devsim_tcl

SET DEVSIM_PY_BAT=%BASEDIR%/devsim.bat
SET DEVSIM_PY3_BAT=%BASEDIR%/devsim_py3.bat
SET DEVSIM_TCL_BAT=%BASEDIR%/devsim_tcl.bat


:: rm -rf run && mkdir run
SET RELEASEDIR=%BASEDIR%/%TAGDIR%
SET PYTHONPATH=%RELEASEDIR%
SET RUNDIR=%RELEASEDIR%/run

if exist "%RUNDIR%" rmdir /s /q "%RUNDIR%"
mkdir "%RUNDIR%"

SET GOLDENDIR=%BASEDIR%/goldenresults

:: put the CMakeLists.txt in the right place
COPY "%BASEDIR%/CMakeLists.txt" "%RELEASEDIR%"

> %DEVSIM_PY_BAT% (
@echo @echo off
echo SET MKL_NUM_THREADS=1
echo call conda activate python2
echo SET PYTHONHOME=%ANACONDAPATH%/python2
echo call %DEVSIM_PY_EXE% %%*
echo SET PYTHONHOME=
echo call conda deactivate
)

> %DEVSIM_PY3_BAT% (
@echo @echo off
echo SET MKL_NUM_THREADS=1
echo call conda activate python3
echo SET PYTHONHOME=%ANACONDAPATH%/python3
echo call %DEVSIM_PY3_EXE% %%*
echo SET PYTHONHOME=
echo call conda deactivate
)

> %DEVSIM_TCL_BAT% (
@echo @echo off
echo SET MKL_NUM_THREADS=1
echo call %DEVSIM_TCL_EXE% %%*
)

cd %RUNDIR%
cmake -DDEVSIM_TEST_GOLDENDIR=%GOLDENDIR% -DDEVSIM_PY_TEST_EXE=%DEVSIM_PY_BAT% -DDEVSIM_PY3_TEST_EXE=%DEVSIM_PY3_BAT% -DDEVSIM_TCL_TEST_EXE=%DEVSIM_TCL_BAT% %RELEASEDIR%
ctest -j2
