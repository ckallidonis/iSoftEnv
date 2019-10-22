#/bin/bash

BUILD_DIST=Intel2019_devel


# Package distribution names
CHROMA_DIST=chroma
CHROMA_GENPROP_DIST=chroma-devel-genprop
QMP_DIST=qmp
QDP_DIST=qdpxx
LIBXML2_DIST=libxml2-2.9.9
QPHIX_DIST=qphix
MGPROTO_DIST=mg_proto
EIGEN_DIST=eigen-3.3.4
HADRON_DIST=hadron
TENSOR_DIST=tensor


# Generic directories
TOPDIR=/work/JLabLQCD/kallidoc/software
SRC_TOP=${TOPDIR}/src
INSTALL_TOP=${TOPDIR}/install/${BUILD_DIST}


# QMP directories
QMP_SRC=${SRC_TOP}/${QMP_DIST}
QMP_INSTALL=${INSTALL_TOP}/${QMP_DIST}

# QDP directories
QDP_SRC=${SRC_TOP}/${QDP_DIST}
QDP_INSTALL=${INSTALL_TOP}/${QDP_DIST}

# libxml2 directories
LIBXML2_SRC=${SRC_TOP}/${LIBXML2_DIST}
LIBXML2_INSTALL=${INSTALL_TOP}/${LIBXML2_DIST}

# Eigen directories
EIGEN_SRC=${SRC_TOP}/${EIGEN_DIST}

# QPHIX directories
QPHIX_SRC=${SRC_TOP}/${QPHIX_DIST}
QPHIX_INSTALL=${INSTALL_TOP}/${QPHIX_DIST}

# MG_PROTO directories
MGPROTO_SRC=${SRC_TOP}/${MGPROTO_DIST}
MGPROTO_INSTALL=${INSTALL_TOP}/${MGPROTO_DIST}

# HADRON directories
HADRON_SRC=${SRC_TOP}/${HADRON_DIST}
HADRON_INSTALL=${INSTALL_TOP}/${HADRON_DIST}

# TENSOR directories
TENSOR_SRC=${SRC_TOP}/${TENSOR_DIST}
TENSOR_INSTALL=${INSTALL_TOP}/${TENSOR_DIST}

# CHROMA directories
CHROMA_SRC=${SRC_TOP}/${CHROMA_DIST}
CHROMA_INSTALL=${INSTALL_TOP}/${CHROMA_DIST}

# CHROMA_GENPROP directories
CHROMA_GENPROP_SRC=${SRC_TOP}/${CHROMA_GENPROP_DIST}
CHROMA_GENPROP_INSTALL=${INSTALL_TOP}/${CHROMA_GENPROP_DIST}



# Build files directory
BUILDDIR=${INSTALL_TOP}/build_files
mkdir -p ${BUILDDIR}


export DIR_SETUP=1
