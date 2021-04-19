#!/bin/bash
#
#################
# BUILD MGPROTO
#################

ENV_SCRIPT=env.Intel_19.0.4_CPU.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION
QPHIX_SOALEN=$ENV_QPHIX_SOALEN

QPHIX_BTAG=${precision}-prec_${PK_QPHIX_ISA}
QDP_BTAG=${precision}-prec

BUILD_TAG=${precision}-prec_${PK_QPHIX_ISA}_soalen${QPHIX_SOALEN}

PKG_SRC=${MGPROTO_SRC}
PKG_INSTALL=${MGPROTO_INSTALL}/${BUILD_TAG}
PKG_DIST=${MGPROTO_DIST}_${BUILD_TAG}


pushd ${BUILDDIR}

BUILD_FILES_DIST=build_${PKG_DIST}

if [ -d ${BUILD_FILES_DIST} ]; 
then 
  rm -rf ${BUILD_FILES_DIST}
fi

mkdir  ${BUILD_FILES_DIST}
cd ${BUILD_FILES_DIST}


if [ -d ${PKG_INSTALL} ]; 
then 
  rm -rf ${PKG_INSTALL}
fi
mkdir -p ${PKG_INSTALL}

export VTUNE_DIR=

CXX=${PK_CXX} CC=${PK_CC} CXXFLAGS="${PK_CXXFLAGS} -g" cmake \
    -G"Eclipse CDT4 - Unix Makefiles" \
    -DMG_USE_KOKKOS=FALSE \
    -DMG_USE_QPHIX=TRUE \
    -DQPHIX_DIR=${QPHIX_INSTALL}/${QPHIX_BTAG} \
    -DMG_QPHIX_COMPRESS12=TRUE \
    -DMG_QPHIX_SOALEN=${QPHIX_SOALEN} \
    -DMG_ENABLE_TIMERS=TRUE \
    -DMG_USE_AVX512=TRUE \
    -DEigen3_DIR=${EIGEN_SRC} \
    -DKOKKOS_ENABLE_CUDA=FALSE \
    -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 \
    -DCMAKE_ECLIPSE_VERSION=4.5.0 \
    -DCMAKE_INSTALL_PREFIX=${PKG_INSTALL} \
    -DKOKKOS_HOST_ARCH="${PK_KOKKOS_HOST_ARCH}" \
    -DQDPXX_DIR=${QDP_INSTALL}/${QDP_BTAG} \
    -DMG_DEFAULT_LOGLEVEL=DEBUG \
    -DMG_KOKKOS_USE_NEIGHBOR_TABLE=FALSE \
     ${PKG_SRC}


    # -DMG_QPHIX_SOALEN=4 \
    # -DEigen3_DIR=${SRCDIR}/eigen-3.3.4 \
    # -DMG_USE_AVX=TRUE \



${MAKE}
${MAKE} install

popd
