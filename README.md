# Windows Tests

Windows 64 bit with latest Anaconda Python, and Intel MKL

Please see ``run_tests.bat``.

Results are sensitive to the CPU and system libraries that may be installed on your machine.

All tests pass on Windows 10 running in vmware on a Macbook Pro 2014.

Requirements:
Python 3 environment installed and actived

The Anaconda prerequisites may be installed using preinstall.bat from the command prompt.

```
cd devsim_tests_win64
preinstall.bat
.\run_tests.bat v1.7.0
```

In the above example, the package ``devsim_msys_v1.7.0.zip`` has been unzipped into the test directory.

