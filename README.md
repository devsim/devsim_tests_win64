Windows 64 bit with latest Anaconda Python, and Intel MKL

Please see ``run_tests.bat``.

Results are sensitive to the CPU and system libraries that may be installed on your machine.

All tests pass on a Windows 11 Desktop with an Intel I9 processor

Requirements:
Python 3 environment installed and actived

The Anaconda prerequisites may be installed using preinstall.bat from the command prompt.

Trial Run from an Anaconda Python command prompt:
```
preinstall.bat
pip install --target devsim_win64_2.7.2 devsim-2.7.2-cp37-abi3-win_amd64.whl
run_tests.bat 2.7.2
```


