#!/bin/sh

#
# cp ../build.sh  .
# cp -r ../linux-arm-gnueabihf-g++ mkspecs/.
# rm -rf /opt/qt
# sudo chown -R wmt:wmt /opt/qt
# make -j4
#

./configure -static -opensource -embedded generic -xplatform linux-arm-gnueabihf-g++ --prefix=/opt/qt -confirm-license -nomake demos -nomake examples -nomake docs -no-opengl -no-webkit -no-openssl -no-javascript-jit

