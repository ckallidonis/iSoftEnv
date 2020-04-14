#!/bin/bash
#
#################
# BUILD Hardron
#################

ENV_SCRIPT=env.Intel2019_0.1.144.sh
source ./${ENV_SCRIPT}

PKG_SRC=${HADRON_SRC}
PKG_INSTALL=${HADRON_INSTALL}
PKG_DIST=${HADRON_DIST}


pushd ${PKG_SRC}
autoreconf -f -i
popd
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


${PKG_SRC}/configure --prefix=${PKG_INSTALL} \
    --with-tensor="${TENSOR_INSTALL}" \
    --host=x86_64-linux-gnu \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}"

${MAKE}
${MAKE} install

popd
