https://www.linuxidc.com/Linux/2011-07/39373.htm

Ubuntu Framebuffer学习笔记
[日期：2011-07-28]	来源：Linux社区  作者：weimingtom	[字体：大 中 小]
一、环境搭建

1. 直接在Ubuntu上运行Framebuffer

默认Ubuntu是直接进入X视窗，如果要使用Framebuffer，

需要修改内核引导参数：

$ sudo gedit /etc/default/grub

查找

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

把它改为

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash text vga=0x311" 

这里text表示进入文本模式，vga=0x311表示使用Framebuffer显示驱动，

0x311是指示色深和分辨率的参数

  |640x480 800x600 1024x768 1280x1024

----+-------------------------------------

256 | 0x301   0x303 0x305 0x307

32k | 0x310   0x313 0x316 0x319

64k | 0x311   0x314 0x317 0x31A

16M | 0x312   0x315 0x318 0x31B

如果使用vga=0x311参数，必须使用后面提到的vesafb模块，并且取消黑名单，

否则无法进入系统，需要光盘启动删除vga参数以还原

$ sudo update-grub

写入到/boot/grub/grub.cfg

$ sudo gedit /etc/initramfs-tools/modules

在其中加入：vesafb

$ sudo gedit /etc/modprobe.d/blacklist-framebuffer.conf

用#注释以下行

# blacklist vesafb

$ sudo update-initramfs -u

（生成新的initrd）

然后重启机器，即可进入Framebuffer

如果要切换回X11，可以输入：

$ startx

有时候/boot/grub/grub.cfg的引导参数不正确导致系统无法引导，

可以用光盘引导系统，挂载硬盘后直接修改/boot/grub/grub.cfg文件

这样就可以跳过update-grub这一步。然后还原原有的引导参数进入X Window

2. 使用qemu虚拟Linux

需要编译Linux内核和busybox。

此外还需要libncurses-dev和qemu。

由于qemu可以直接加载内核和initrd，指定引导参数，

所以不需要修改grub配置。

(1)编译内核和安装qemu

$ tar xjf linux-2.6.39.2.tar.bz2

$ cd linux-2.6.39.2/

$ make help

$ make i386_defconf

$ sudo apt-get install libncurses-dev

$ make menuconfig

$ make

$ sudo apt-get install qemu

$ qemu --help

$ qemu -kernel arch/x86/boot/bzImage

$ qemu -kernel arch/x86/boot/bzImage -append "noapic"

有时候内核会这样崩溃：

MP-BIOS BUG 8254 timer not connected

trying to set up timer as Virtual Wire IRQ

所以需要添加-append "noapic"参数

(2) 修改内核配置，然后重新编译内核。

注意，不同内核版本的配置不一样，

我的内核配置作如下改动（用空格切换为*，不要切换为M）：

$ make menuconfig

Device Drivers  --->  

Graphics support  --->   

-*- Support for frame buffer devices  --->  

[*]   VESA VGA graphics support 

因为VESA支持彩色色深的显示。

默认是不选的，只能是黑白控制台。

Input device support  ---> 

[*]     Provide legacy /dev/psaux device 

有些库如SDL在识别USB接口的鼠标时会寻找/dev/input/mice和/dev/psaux，

我发现我编译的内核没有前者，所以用这个选项制造出/dev/psaux设备。

File systems  --->  

[*] Miscellaneous filesystems  --->

<*>   Compressed ROM file system support (cramfs) 

个人喜欢cramfs，不过不是必须的，可以用这个开关编译cramfs驱动，

测试initramfs是否正常

General setup  ---> 

[*]   Support initial ramdisks compressed using gzip 

[*] Embedded system

默认i86内核的配置不支持gzip压缩的cpio格式initrd，所以需要手动打开它。

最后重新编译内核：

$ make

(3) 编译busybox

$ tar xjf busybox-1.18.5.tar.bz2

$ cd busybox-1.18.5/

$ make defconfig

$ make menuconfig

设置修改如下：

Busybox Settings  --->  

Build Options  --->

[*] Build BusyBox as a static binary (no shared libs)  

$ make 

$ make install

默认文件安装在当前目录的_install目录下。

(4) 制作cpio封包gzip压缩的initrd

$ cd ../busybox-1.18.5/_install/

$ mkdir proc sys dev etc etc/init.d tmp root usr lib

$ gedit etc/init.d/rcS

#!/bin/sh

mount -t proc none /proc

mount -t sysfs none /sys

/sbin/mdev -s

$ chmod +x etc/init.d/rcS

$ cd ../../linux-2.6.39.2/

$ gedit prerun.sh

#!/bin/sh

cd ../busybox-1.18.5/_install

find . | cpio -o --format=newc > ../rootfs.img

cd .. 

gzip -c rootfs.img > rootfs.img.gz

cd ../linux-2.6.39.2/

$ . prerun.sh

$ gedit run.sh

#!/bin/sh

qemu -kernel ./arch/i386/boot/bzImage -initrd ../busybox-1.18.5/rootfs.img.gz  -append "root=/dev/ram rdinit=/sbin/init vga=0x312 noapic"

注意这里用rdinit=，如果用init=就成了initramfs（内核会报告找不到合适的文件系统）

关于vga=的参数设置见前面（决定色深和分辨率）

$ . run.sh

编译程序，然后用上面写的prerun.sh打包进rootfs.img.gz，然后运行run.sh跑qemu即可。

如果程序是动态链接，需要特定的动态库，

可以把依赖的动态库复制到_install/lib目录下，打包到rootfs.img.gz中。

(5) 进入qemu的效果如下：
