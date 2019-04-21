# mtools_win32
A docker container to build a native mingw-w64-based copy of mtools for 32bit Windows

## Description

This was built on top of Docker 18.09.5, and creates a ubuntu:18.04 container that uses mingw-w64-i686 to 
compile the mtools project and generate native windows binaries for the assorted tools.

It's based on mtools upstream version 4.0.23, with minor modifications to Makefile.in to fix EXEEXT issues that were preventing the executables
from being generated with the right extensions.

## Usage

$ docker build -t mtools . && docker run -v $(realpath compiled):/compiled -it mtools:latest

This will create a subdirectory named compiled, with the executables in compiled/bin

## Future improvements

* Filesize is much larger than it should be, as there's no sharing of code between the EXEs.
* mtools is not being compiled with libiconv support. This'd improve handling of character sets, but there's no mingw-based libiconv, and the existing [win_iconv project](https://github.com/win-iconv/win-iconv) doesn't support langinfo.h which is needed by mtool's use of libiconv.
* No tests or other CI. Right now it's all semi-manual. 
* There's no work done to ensure this Docker container will function forever. Once Ubuntu drops support for 18.04 the apt-get it runs will fail and this container will expire.
