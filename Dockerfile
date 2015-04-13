FROM centos:6.6
MAINTAINER Yeonghoon Park <me@yhpark.io>

RUN yum install -y compat-gcc-34
RUN yum install -y compat-gcc-34-c++
RUN yum install -y tar patch
RUN yum install -y ncurses-devel ncurses

RUN ln /usr/bin/gcc34 /usr/bin/gcc
RUN ln /usr/bin/g++34 /usr/bin/g++

RUN yum install -y compat-glibc-headers
RUN cp -r /usr/lib/x86_64-redhat-linux5E/include/* /usr/local/include/

RUN yum install -y perl
RUN yum install -y gdb

ENV setup_dir /setup
ENV pintos_dir /pintos


WORKDIR $setup_dir

ADD pintos-misc $setup_dir/pintos/src/misc/
ADD pintos-utils $setup_dir/pintos-utils/

ADD http://jaist.dl.sourceforge.net/project/bochs/bochs/2.2.6/bochs-2.2.6.tar.gz $setup_dir/bochs-2.2.6.tar.gz

RUN SRCDIR=$setup_dir DSTDIR=/usr/ PINTOSDIR=$setup_dir/pintos $setup_dir/pintos/src/misc/bochs-2.2.6-build.sh

ADD http://pkgs.repoforge.org/qemu/qemu-0.15.0-1.el6.rfx.x86_64.rpm $setup_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm
RUN yum install -y libGL SDL libaio alsa-lib bluez-libs celt051 esound-libs gnutls libjpeg-turbo pixman libpng pulseaudio-libs spice-server qemu-img
RUN rpm -i $setup_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm

WORKDIR $setup_dir/pintos-utils/
RUN make

WORKDIR $pintos_dir

VOLUME [$pintos_dir]

env PATH $setup_dir/pintos-utils/:$PATH
