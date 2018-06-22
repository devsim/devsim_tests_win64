Windows 64 bit with Anaconda Python 2.7, Anaconda Python 3.6, and Intel MKL

Please see run_tests.bat.

Results are sensitive to the CPU and system libraries that may be installed on your machine.

All tests pass on Windows 7 running in vmware on a Macbook Pro 2015.

Requirements:
Python 2.7 (Miniconda installed in %USERPROFILE%/Miniconda2)
Python 3.6 environment installed as python3
Tcl 8.6 installed in the base environment
CMAKE installed in the base environment

conda install cmake tk
conda create -n python2
conda activate python2
conda install numpy mkl
conda deactivate
conda create -n python3 python=3
conda activate python3
conda install numpy mkl
conda deactivate


Cygwin 32 bit with diff and perl utilities

