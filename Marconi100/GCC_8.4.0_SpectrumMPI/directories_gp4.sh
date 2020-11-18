#/bin/bash

BUILD_DIST_GP4=GCC_8.4.0_SpectrumMPI


# Package distribution names
CHROMA_DIST_GP4=chroma_gp4
QMP_DIST_GP4=qmp
QDP_DIST_GP4=qdpxx
LIBXML2_DIST_GP4=libxml2
QDP3D_DIST_GP4=qdpxx_3d
HADRON_DIST_GP4=hadron
HAROM_DIST_GP4=harom_gp4
QUDA_DIST_GP4=quda_develop
EIGEN_DIST_GP4=eigen-3.3.4

# Generic directories
TOPDIR_GP4=/m100_work/Pra21_5389/kallidoc/software
SRC_TOP_GP4=${TOPDIR_GP4}/src_gp4
INSTALL_TOP_GP4=${TOPDIR_GP4}/install_gp4/${BUILD_DIST_GP4}


# QMP directories
QMP_SRC_GP4=${SRC_TOP_GP4}/${QMP_DIST_GP4}
QMP_INSTALL_GP4=${INSTALL_TOP_GP4}/${QMP_DIST_GP4}

# LIBXML2 directories
LIBXML2_SRC_GP4=${SRC_TOP_GP4}/${LIBXML2_DIST_GP4}
LIBXML2_INSTALL_GP4=${INSTALL_TOP_GP4}/${LIBXML2_DIST_GP4}

# QDP directories
QDP_SRC_GP4=${SRC_TOP_GP4}/${QDP_DIST_GP4}
QDP_INSTALL_GP4=${INSTALL_TOP_GP4}/${QDP_DIST_GP4}

# QDP-3D directories (Source code is same as QDP, installation is different)
QDP3D_SRC_GP4=${SRC_TOP_GP4}/${QDP_DIST_GP4}
QDP3D_INSTALL_GP4=${INSTALL_TOP_GP4}/${QDP3D_DIST_GP4}

# HADRON directories
HADRON_SRC_GP4=${SRC_TOP_GP4}/${HADRON_DIST_GP4}
HADRON_INSTALL_GP4=${INSTALL_TOP_GP4}/${HADRON_DIST_GP4}

# TENSOR directories, we are using XL/IBM build of Tensor!!
TENSOR_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_gp4/XL_16.1.1_SpectrumMPI/tensor

# CHROMA directories
CHROMA_SRC_GP4=${SRC_TOP_GP4}/${CHROMA_DIST_GP4}
CHROMA_INSTALL_GP4=${INSTALL_TOP_GP4}/${CHROMA_DIST_GP4}

# HAROM directories
HAROM_SRC_GP4=${SRC_TOP_GP4}/${HAROM_DIST_GP4}
HAROM_INSTALL_GP4=${INSTALL_TOP_GP4}/${HAROM_DIST_GP4}

# QUDA directories
QUDA_SRC_GP4=${SRC_TOP_GP4}/${QUDA_DIST_GP4}
QUDA_INSTALL_GP4=${INSTALL_TOP_GP4}/${QUDA_DIST_GP4}

# Eigen directories
EIGEN_SRC_GP4=${SRC_TOP_GP4}/${EIGEN_DIST_GP4}

# Build files directory
BUILDDIR_GP4=${INSTALL_TOP_GP4}/build_files
mkdir -p ${BUILDDIR_GP4}


export DIR_SETUP_GP4=1
