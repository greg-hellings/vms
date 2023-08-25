# Building on Windows

1. Install Cygwin with packages; I install to C:\Cygwin64 as per defaults
  * python39
  * python39-setuptools
  * python39-cryptography
  * python39-pip
  * openssl-devel
  * libffi-devel
  * python3-devel
  * zlib
  * zlib-devel
1. Inside of Cygwin
  1. Create a venv *with system packages* enabled
  1. Install windows/ansible-requirements.txt into the venv
  1. Update the path in ansible/hyperv-wrapper.py to point to your VENV
  1. Execute pyinstaller --onefile ansible/hyperv-wrapper.py