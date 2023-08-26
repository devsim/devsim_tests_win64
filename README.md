Windows 64 bit with latest Anaconda Python, and Intel MKL

Please see ``run_tests.bat``.

Results are sensitive to the CPU and system libraries that may be installed on your machine.

All tests pass on Windows 10 running in vmware on a Macbook Pro 2014.

Requirements:
Python 3 environment installed and actived

The Anaconda prerequisites may be installed using preinstall.bat from the command prompt.

Trial Run from an Anaconda Python command prompt:
```
preinstall.bat
pip install --target devsim_win64_v2.6.0 devsim-2.6.0-cp37-abi3-win_amd64.whl
run_tests.bat v2.6.0
```


