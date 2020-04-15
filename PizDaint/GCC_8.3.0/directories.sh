#/bin/bash

BUILD_DIST=GCC_8.3.0


# Package distribution names
LLVM_DIST=llvm-8.0.0

# Generic directories
TOPDIR=/users/kallidoc/software
SRC_TOP=${TOPDIR}/src
INSTALL_TOP=${TOPDIR}/install/${BUILD_DIST}


# LLVM directories
LLVM_SRC=${SRC_TOP}/${LLVM_DIST}
LLVM_INSTALL=${INSTALL_TOP}/${LLVM_DIST}


# Build files directory
BUILDDIR=${INSTALL_TOP}/build_files
mkdir -p ${BUILDDIR}


export DIR_SETUP=1
