#/bin/bash

BUILD_DIST_GP4=GCC_8.4.0_SpectrumMPI


# Package distribution names
CHROMA_DIST_GP4=chroma-genprop4
CHROMA_DIST_ORIG_GP4=chroma-genprop4-orig
QMP_DIST_GP4=qmp
QDP_DIST_GP4=qdpxx
QDP3D_DIST_GP4=qdpxx_3d
HADRON_DIST_GP4=hadron
TENSOR_DIST_GP4=tensor
HAROM_DIST_GP4=harom-genprop4
QUDA_DIST_GP4=quda_genprop4
EIGEN_DIST_GP4=eigen-3.3.4

# Generic directories
TOPDIR_GP4=/m100_work/Pra21_5389/kallidoc/software
SRC_TOP_GP4=${TOPDIR_GP4}/src_genprop4
INSTALL_TOP_GP4=${TOPDIR_GP4}/install_genprop4/${BUILD_DIST_GP4}


# QMP directories
QMP_SRC_GP4=${SRC_TOP_GP4}/${QMP_DIST_GP4}
QMP_INSTALL_GP4=${INSTALL_TOP_GP4}/${QMP_DIST_GP4}
QMP_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_genprop4/XL_16.1.1_SpectrumMPI/qmp

# QDP directories
QDP_SRC_GP4=${SRC_TOP_GP4}/${QDP_DIST_GP4}
QDP_INSTALL_GP4=${INSTALL_TOP_GP4}/${QDP_DIST_GP4}
QDP_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_genprop4/XL_16.1.1_SpectrumMPI/qdpxx

# QDP-3D directories (Source code is same as QDP, installation is different)
QDP3D_SRC_GP4=${SRC_TOP_GP4}/${QDP_DIST_GP4}
QDP3D_INSTALL_GP4=${INSTALL_TOP_GP4}/${QDP3D_DIST_GP4}
QDP3D_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_genprop4/XL_16.1.1_SpectrumMPI/qdpxx_3d

# HADRON directories
HADRON_SRC_GP4=${SRC_TOP_GP4}/${HADRON_DIST_GP4}
HADRON_INSTALL_GP4=${INSTALL_TOP_GP4}/${HADRON_DIST_GP4}
HADRON_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_genprop4/XL_16.1.1_SpectrumMPI/hadron

# TENSOR directories
TENSOR_SRC_GP4=${SRC_TOP_GP4}/${TENSOR_DIST_GP4}
TENSOR_INSTALL_GP4=${INSTALL_TOP_GP4}/${TENSOR_DIST_GP4}
TENSOR_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_genprop4/XL_16.1.1_SpectrumMPI/tensor

# CHROMA directories
CHROMA_SRC_GP4=${SRC_TOP_GP4}/${CHROMA_DIST_GP4}
CHROMA_INSTALL_GP4=${INSTALL_TOP_GP4}/${CHROMA_DIST_GP4}

# HAROM directories
HAROM_SRC_GP4=${SRC_TOP_GP4}/${HAROM_DIST_GP4}
HAROM_INSTALL_GP4=${INSTALL_TOP_GP4}/${HAROM_DIST_GP4}
HAROM_INSTALL_XL_GP4=/m100_work/Pra21_5389/kallidoc/software/install_genprop4/XL_16.1.1_SpectrumMPI/harom

# QUDA directories
QUDA_SRC_GP4=${SRC_TOP_GP4}/${QUDA_DIST_GP4}
QUDA_INSTALL_GP4=${INSTALL_TOP_GP4}/${QUDA_DIST_GP4}

# Eigen directories
EIGEN_SRC_GP4=${SRC_TOP_GP4}/${EIGEN_DIST_GP4}

# Build files directory
BUILDDIR_GP4=${INSTALL_TOP_GP4}/build_files
mkdir -p ${BUILDDIR_GP4}


export DIR_SETUP_GP4=1
