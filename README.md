Windows 64 bit with Intel MKL

Please see ``run_tests.bat``.

Results are sensitive to the CPU and system libraries that may be installed on your machine.

All tests pass on a Windows 11 Desktop with an Intel I9 processor

Requirements:
Python 3 environment installed and activated.  `uv` may be used for convenience.

Trial Run for Python 3.15
```
uv python install 3.15
uv venv venv --python 3.15
venv\Scripts\activate
uv pip install numpy mkl
uv pip install --target devsim_win64_2.12.0_abi3 devsim-2.12.0-cp39-abi3-win_amd64.whl
run_tests.bat 2.12.0_abi3
uv pip freeze > requirements.txt
```

Trial Run for Python 3.15t
```
uv python install 3.15t
uv venv venvt --python 3.15t
venvt\Scripts\activate
uv pip install numpy mkl
uv pip install --target devsim_win64_2.12.0_abi3t devsim-2.12.0-cp315-abi3t-win_amd64.whl
run_tests.bat 2.12.0_abi3t
```

Please note that results are sensitive to MKL version.  Please check `requirements.txt` or `goldenresults/testing/info.out` for version the tests were run on.
