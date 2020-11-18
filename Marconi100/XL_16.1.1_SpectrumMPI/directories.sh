#/bin/bash

BUILD_DIST=XL_16.1.1_SpectrumMPI


# Package distribution names
CHROMA_DIST=chroma-genprop4
QMP_DIST=qmp
QDP_DIST=qdpxx
QDP3D_DIST=qdpxx_3d
HADRON_DIST=hadron
TENSOR_DIST=tensor
HAROM_DIST=harom
QUDA_DIST=quda_develop
LIBXML2_DIST=libxml2
EIGEN_DIST=eigen-3.3.4

# Generic directories
TOPDIR=/m100_work/Pra21_5389/kallidoc/software
SRC_TOP=${TOPDIR}/src_genprop4
INSTALL_TOP=${TOPDIR}/install_genprop4/${BUILD_DIST}


# QMP directories
QMP_SRC=${SRC_TOP}/${QMP_DIST}
QMP_INSTALL=${INSTALL_TOP}/${QMP_DIST}

# QDP directories
QDP_SRC=${SRC_TOP}/${QDP_DIST}
QDP_INSTALL=${INSTALL_TOP}/${QDP_DIST}

# QDP-3D directories (Source code is same as QDP, installation is different)
QDP3D_SRC=${SRC_TOP}/${QDP_DIST}
QDP3D_INSTALL=${INSTALL_TOP}/${QDP3D_DIST}

# HADRON directories
HADRON_SRC=${SRC_TOP}/${HADRON_DIST}
HADRON_INSTALL=${INSTALL_TOP}/${HADRON_DIST}

# TENSOR directories
TENSOR_SRC=${SRC_TOP}/${TENSOR_DIST}
TENSOR_INSTALL=${INSTALL_TOP}/${TENSOR_DIST}

# CHROMA directories
CHROMA_SRC=${SRC_TOP}/${CHROMA_DIST}
CHROMA_INSTALL=${INSTALL_TOP}/${CHROMA_DIST}

# HAROM directories
HAROM_SRC=${SRC_TOP}/${HAROM_DIST}
HAROM_INSTALL=${INSTALL_TOP}/${HAROM_DIST}

# LIBXML2 directories
LIBXML2_SRC=${SRC_TOP}/${LIBXML2_DIST}
LIBXML2_INSTALL=${INSTALL_TOP}/${LIBXML2_DIST}

# QUDA directories
QUDA_SRC=${SRC_TOP}/${QUDA_DIST}
QUDA_INSTALL=${INSTALL_TOP}/${QUDA_DIST}
QUDA_INSTALL_GCC=/m100_work/Pra21_5389/kallidoc/software/install/GCC_8.4.0_SpectrumMPI/quda_noJIT

# Eigen directories
EIGEN_SRC=${SRC_TOP}/${EIGEN_DIST}

# Build files directory
BUILDDIR=${INSTALL_TOP}/build_files
mkdir -p ${BUILDDIR}


export DIR_SETUP=1