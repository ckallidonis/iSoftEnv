#/bin/bash

BUILD_DIST=GCC_8.3.0

# Package distribution names
QMP_DIST=qmp_jit
LIBXML2_DIST=libxml2
LLVM_DIST=llvm-8.0.0.GNU
QDPJIT_DIST=qdp-jit-llvm-nvptx-GNU
CHROMA_DIST=chroma_jit
QUDA_DIST=quda_jit
EIGEN_DIST=eigen-3.3.4

# Generic directories
TOPDIR=/users/kallidoc/software
SRC_TOP=${TOPDIR}/src
INSTALL_TOP=$SCRATCH/software/install/${BUILD_DIST}

# QMP directories
QMP_SRC=${SRC_TOP}/${QMP_DIST}
QMP_INSTALL_GNU=${INSTALL_TOP}/${QMP_DIST}

# LLVM directories
LLVM_SRC=${SRC_TOP}/${LLVM_DIST}
LLVM_INSTALL=${INSTALL_TOP}/${LLVM_DIST}

# LIBXML2 directories
LIBXML2_SRC=${SRC_TOP}/${LIBXML2_DIST}
LIBXML2_INSTALL_GNU=${INSTALL_TOP}/${LIBXML2_DIST}

# QDP-JIT directories
QDPJIT_SRC=${SRC_TOP}/${QDPJIT_DIST}
QDPJIT_INSTALL=${INSTALL_TOP}/${QDPJIT_DIST}

# CHROMA directories
CHROMA_SRC=${SRC_TOP}/${CHROMA_DIST}
CHROMA_INSTALL=${INSTALL_TOP}/${CHROMA_DIST}

# QUDA directories
QUDA_SRC=${SRC_TOP}/${QUDA_DIST}
QUDA_INSTALL=${INSTALL_TOP}/${QUDA_DIST}

# Eigen directories
EIGEN_SRC=${SRC_TOP}/${EIGEN_DIST}

# Build files directory
BUILDDIR=${INSTALL_TOP}/build_files
mkdir -p ${BUILDDIR}


export DIR_SETUP=1
