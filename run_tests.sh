#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_win64_${TAG}
TAGTGZ=${TAGDIR}.tgz
DEVSIM_PY=${BASEDIR}/${TAGDIR}/bin/devsim
DEVSIM_TCL=${BASEDIR}/${TAGDIR}/bin/devsim_tcl
ANACONDA_PATH=/cygdrive/C/Miniconda-x64
CMAKE=/cygdrive/C/Program\ Files\ \(x86\)/CMake/bin/cmake
CTEST=/cygdrive/C/Program\ Files\ \(x86\)/CMake/bin/ctest
DEVSIM_PY_EXE=${BASEDIR}/${TAGDIR}/bin/devsim
DEVSIM_TCL_EXE=${BASEDIR}/${TAGDIR}/bin/devsim_tcl

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 

# symlinks do not work on windows
for i in testing examples; do \
  #rm -rf $i; \
  cp -r ${TAGDIR}/$i .; \
done
  
export PYTHONPATH=`cygpath -w ${BASEDIR}/${TAGDIR}`
# sequential really speeds things up
export MKL_NUM_THREADS=1
rm -rf run && mkdir run
(cd run && "${CMAKE}" -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY_TEST_EXE=${DEVSIM_PY_EXE} -DDEVSIM_TCL_TEST_EXE=${DEVSIM_TCL_EXE} ..)
(cd run && "${CTEST}" -j2)
