#!/bin/bash
#
#################
# BUILD Hardron
#################

ENV_SCRIPT=env.GCC_8.4.0_SpectrumMPI.sh
source ./${ENV_SCRIPT}

PKG_SRC=${HADRON_SRC_GP4}
PKG_INSTALL=${HADRON_INSTALL_GP4}
PKG_DIST=${HADRON_DIST_GP4}


pushd ${PKG_SRC}
autoreconf -f -i
popd
pushd ${BUILDDIR_GP4}

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


${PKG_SRC}/configure --prefix=${PKG_INSTALL} \
    --with-tensor="${TENSOR_INSTALL_XL_GP4}" \
    --host=x86_64-linux-gnu \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}"

${MAKE}
${MAKE} install

popd
