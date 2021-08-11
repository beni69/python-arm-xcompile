#!/bin/bash

TARGET_HOST="arm-linux-gnueabi"
ROOT_FILESYSTEM="/usr/arm-linux-gnueabi/"
BUILD_HOST="x86_64-linux-gnu" # find out with uname -m
WORKING_DIRECTORY="_build"
INSTALL_DIRECTORY="$WORKING_DIRECTORY/_install"
PYTHON_VERSION="3.9.6"
SOURCE_DIRECTORY="Python-$PYTHON_VERSION"
PYTHON_ARCHIVE="Python-$PYTHON_VERSION.tar.xz"
ENABLE_MODULES="array cmath binascii _collections cPickle cStringIO datetime
_elementtree fcntl _functools itertools _io math _md5 operator _random select
_sha _socket _struct termios time unicodedata zlib"


# Preparing compile environment
export RFS="$ROOT_FILESYSTEM"
mkdir -p "$INSTALL_DIRECTORY"
PREFIX=$(readlink --no-newline --canonicalize "$INSTALL_DIRECTORY")

# Step 1 - Downloading Python and extracting
cd $WORKING_DIRECTORY
wget -c http://www.python.org/ftp/python/$PYTHON_VERSION/$PYTHON_ARCHIVE
rm -rf $SOURCE_DIRECTORY
tar -xf $PYTHON_ARCHIVE
cd $SOURCE_DIRECTORY

# Step 2 - Enable modules by uncommenting them in Modules/Setup.dist
for module in $ENABLE_MODULES
do
    sed "s/^#$module/$module/" -i Modules/Setup.dist
done

# Step 3 - Cross-Compile
make distclean
./configure --host=$TARGET_HOST --build=$BUILD_HOST --prefix=$PREFIX \
    --disable-ipv6 --enable-unicode=ucs4 \
    --enable-optimizations \
    ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no \
    ac_cv_have_long_long_format=yes

make -j$(nproc)
make altinstall

