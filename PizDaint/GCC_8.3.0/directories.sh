#/bin/bash

BUILD_DIST=GCC_8.3.0

# Package distribution names
QMP_DIST=qmp
LLVM_DIST=llvm-8.0.0
QDPJIT_DIST=qdp-jit
#QDPJIT_DIST=qdp-jit-llvm-nvptx

# Generic directories
TOPDIR=/users/kallidoc/software
SRC_TOP=${TOPDIR}/src
INSTALL_TOP=${TOPDIR}/install/${BUILD_DIST}

# QMP directories
QMP_SRC=${SRC_TOP}/${QMP_DIST}
QMP_INSTALL=${INSTALL_TOP}/${QMP_DIST}

# LLVM directories
LLVM_SRC=${SRC_TOP}/${LLVM_DIST}
LLVM_INSTALL=${INSTALL_TOP}/${LLVM_DIST}

# QDP-JIT directories
QDPJIT_SRC=${SRC_TOP}/${QDPJIT_DIST}
QDPJIT_INSTALL=${INSTALL_TOP}/${QDPJIT_DIST}


# Build files directory
BUILDDIR=${INSTALL_TOP}/build_files
mkdir -p ${BUILDDIR}


export DIR_SETUP=1
