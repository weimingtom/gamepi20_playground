qt nes
https://whycan.com/t_7253.html
qt4-NES4_5_512_480_640_480.7z
qt4-NES4_5_512_480_640_480_try_high_speed.7z
https://whycan.com/t_5312.html


./configure -release -xplatform linux-arm-gnueabi-g++  -prefix /opt/qt4.8.7_armlib -opensource -confirm-license -qt-sql-sqlite -qt-gfx-linuxfb -plugin-sql-sqlit -no-qt3support -no-phonon -no-svg -no-webkit -no-javascript-jit -no-script -no-scripttools -no-declarative -no-declarative-debug -qt-zlib -no-gif -qt-libtiff -qt-libpng -no-libmng -qt-libjpeg -no-rpath -no-pch -no-3dnow -no-avx -no-neon -no-openssl -no-nis -no-cups -no-dbus -embedded arm -platform linux-g++ -little-endian -qt-freetype -no-opengl -no-glib -nomake demos -nomake examples -nomake docs

#include<QApplication>

#include<QLabel>

int main(int argc, char** argv)

{

   QApplication app(argc,argv);

   QLabel *label = new QLabel("Hello wyhcan!");
   label->setGeometry(300,100,200,200);
   label->show();

   return app.exec();

}

然后就的用上我们上面说的qmake了。没有加入查找目录就带上路径运行qmake
在hello.cpp 目录下
1. qmake -project 生成helloworld.pro 这个名字是根据你的工程目录名字来命令的
2. qmake helloworld.pro 生成Makefile
3. make 生成可运行程序helloworld

