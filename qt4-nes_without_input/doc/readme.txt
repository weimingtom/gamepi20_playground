These toolchains are deprecated. They are outdated and easily available from other sources (e.g. direct from Ubuntu apt). e.g.

sudo apt-get install gcc-arm-linux-gnueabihf
There is also an aarch64 version:

sudo apt-get install gcc-aarch64-linux-gnu
Note: if building for Pi0/1 using --with-arch=armv6 --with-float=hard --with-fpu=vfp is recommended (and matches the default flags of the toolchains included here).

---------
https://github.com/raspberrypi/tools


-------------

$ nano NesEmulateWindow.cpp
./hdl.nes
$ cd Qt
$ /opt/qt/bin/qmake Qt.pro
$ make clean all
$ cp Qt Qt_local
$ nano NesEmulateWindow.cpp
/home/pi/hdl.nes
$ make clean all
$ cp Qt Qt_boot

