#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_win64_${TAG}
TAGTGZ=${TAGDIR}.tgz
DEVSIM_PY=${TAGDIR}/bin/devsim
DEVSIM_TCL=${TAGDIR}/bin/devsim_tcl
ANACONDA_PATH=/cygdrive/C/Miniconda-x64
CMAKE=/cygdrive/C/Program\ Files\ \(x86\)/CMake/bin/cmake
CTEST=/cygdrive/C/Program\ Files\ \(x86\)/CMake/bin/ctest

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 

mkdir -p bin

# symlinks do not work on windows
for i in testing examples; do \
  rm -rf $i; \
  cp -r ${TAGDIR}/$i .; \
done
  

rm -rf run && mkdir run
(cd run && "${CMAKE}" -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY_TEST_EXE=${TAGDIR}/bin/devsim -DDEVSIM_TCL_TEST_EXE=${TAGDIR}/bin/devsim_tcl ..)
(cd run && "${CTEST}" -j2)
