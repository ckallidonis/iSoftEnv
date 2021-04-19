#!/bin/bash
#
#################
# BUILD OPENBLAS
#################

ENV_SCRIPT=env.GCC_8.3.1_OpenMPI_4.0.2_cuda_10.2_Genprop5.sh
source ./${ENV_SCRIPT}

PKG_SRC=${OPENBLAS_SRC}
PKG_INSTALL=${OPENBLAS_INSTALL}
PKG_DIST=${OPENBLAS_DIST}

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


make -C ${PKG_SRC} \
     CXXFLAGS="${PK_CXXFLAGS}" \
     CC="${PK_CC_SERIAL}" \
     FC="${PK_FF}"

make -C ${PKG_SRC} install \
     PREFIX=${PKG_INSTALL} \
     CXXFLAGS="${PK_CXXFLAGS}" \
     CC="${PK_CC_SERIAL}" \
     FC="${PK_FF}"

popd
