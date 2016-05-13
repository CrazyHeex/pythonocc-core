#!/bin/sh
set -e
cd /c/projects/pythonocc-core
if [ "$ARCH" = Win32 ]; then
  PATH=$PATH:/c/MinGW/bin
elif [ "$ARCH" = i686 ]; then 
  f=i686-4.9.3-release-posix-dwarf-rt_v4-rev1.7z
  if ! [ -e $f ]; then
    echo "Downloading $f"
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.3/threads-posix/dwarf/$f
  fi
  7z x $f > /dev/null
  echo "Extracting $f"
  mv mingw32 /MinGW
else
  f=x86_64-5.2.0-release-posix-seh-rt_v4-rev0.7z
  if ! [ -e $f ]; then
    echo "Downloading $f"
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/5.2.0/threads-posix/seh/$f
  fi
  echo "Extracting $f"
  7z x $f > /dev/null
  mv mingw64 /MinGW
fi
# download/extract oce-0.16.1
f=OCE-0.16.1-Mingw32.zip
if ! [ -e $f ]; then
  echo "Downloading $f"
  curl -LsSO https://github.com/tpaviot/oce/releases/download/OCE-0.16.1/$f
fi
echo "Extracting $f"
7z x $f > /dev/null
# download/extract sig3.0.8
#f=swigwin-3.0.8.zip
#if ! [ -e $f ]; then
#  echo "Downloading $f"
#  curl -LsSO https://sourceforge.net/projects/swig/files/swigwin/swigwin-3.0.8/$f
#fi
#echo "Extracting $f"
#7z x $f > /dev/null
#
echo "current directory"
pwd
ls C:/projects/pythonocc-core/OCE-0.16.1-Mingw32/cmake
#ls C:/projects/pythonocc-core/swigwin-3.0.8
g++ -v
# make pythonocc-core
# test if file is present
#ls C:/projects/pythonocc-core/src/SWIG_files/wrapper
cd /c/projects/pythonocc-core
mkdir cmake-build
cd cmake-build
cmake -DOCE_DIR=C:/projects/pythonocc-core/OCE-0.16.1-Mingw32/cmake \
      -G'MSYS Makefiles' ..
#-DOCEINCLUDE_PATH=C\\projects\\pythonocc-core\\OCE-0.16.1-Mingw32\\include\\oce \
#      -DOCE_LIB_PATH=C\\projects\\pythonocc-core\\OCE-0.16.1-Mingw32\\Win32\\lib \
      #      -DSWIG_EXECUTABLE=C:/projects/pythonocc-core/swigwin-3.0.8/swig.exe \
#      -DSWIG_DIR=C:/projects/pythonocc-core/swigwin-3.0.8/Lib \
mingw32-make -j4
mingw32-make install
