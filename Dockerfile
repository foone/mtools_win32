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

CMD rm -rf /compiled/* && ./configure -enable-xdf --host=i686-w64-mingw32 --prefix=/compiled && make install

#RUN
