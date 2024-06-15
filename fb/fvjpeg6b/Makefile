CC := gcc
# CC := /home/wmt/work_licheerv/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.2.4/bin/riscv64-unknown-linux-gnu-gcc
CPP := g++
AR := ar
RANLIB := ranlib
RM := rm -rf

CFLAGS := -g3 -O0 
CFLAGS += -I.
CPPFLAGS := $(CFLAGS)

TARGET := libjpeg6b.a

OBJECTS := 
OBJECTS += jcapimin.o jcapistd.o jccoefct.o jccolor.o jcdctmgr.o jchuff.o
OBJECTS += jcinit.o jcmainct.o jcmarker.o jcmaster.o jcomapi.o jcparam.o
OBJECTS += jcphuff.o jcprepct.o jcsample.o jctrans.o jdapimin.o jdapistd.o
OBJECTS += jdatadst.o jdatasrc.o jdcoefct.o jdcolor.o jddctmgr.o jdhuff.o
OBJECTS += jdinput.o jdmainct.o jdmarker.o jdmaster.o jdmerge.o jdphuff.o
OBJECTS += jdpostct.o jdsample.o jdtrans.o jerror.o jfdctflt.o jfdctfst.o
OBJECTS += jfdctint.o jidctflt.o jidctred.o jquant1.o
OBJECTS += jquant2.o jutils.o jmemmgr.o
OBJECTS += jmemmgr.o jmemnobs.o
OBJECTS += jidctint.o  jidctfst.o

all: $(TARGET) fv

fv: $(TARGET) fv.c
	$(CC) $(CFLAGS) -o $@ fv.c -L. -ljpeg6b

$(TARGET): $(OBJECTS)
	$(AR) cr $@ $^
	#$(RANLIB) $@

clean:
	$(RM) $(TARGET) $(OBJECTS) fv

test:
	sudo ./fv pic1.jpg

