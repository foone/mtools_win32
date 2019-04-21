FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	mingw-w64-tools mingw-w64-i686-dev \
	gcc-mingw-w64-i686 g++-mingw-w64-i686 \
	binutils-mingw-w64-i686

WORKDIR /build

COPY src /build/mtools

WORKDIR /build/mtools

# Don't ask.
RUN rm /bin/ln
# OK since you asked, the configuration for mtools assumes it can symlink all
# the files to the mtools binary, even if you're targeting an OS where that
# won't work necessarily. So the easiest way to tell configure not to use 
# symlinks? Delete the tool for symlinking!
# A better way would be to change the autoconf script to determine when
# we're targeting windows, but that's above my pay grade.

CMD rm -rf /compiled/* && ./configure -enable-xdf --host=i686-w64-mingw32 --prefix=/compiled && make install && strip /compiled/bin/*.exe
