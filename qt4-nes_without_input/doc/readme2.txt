工具链：用raspberrypi/tools，参数是-march=armv6，g++参数加上-std=gnu++98
QWS_DISPLAY：看代码，QWS_DISPLAY=:/dev/fb1，冒号前面可能是qt驱动名，忽略

缺点：如果启动运行qws，会导致hdmi的终端没办法登录（键盘被第二屏幕占用）

