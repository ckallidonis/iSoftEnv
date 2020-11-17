#!/bin/bash
#
#################
# BUILD Harom
#################

ENV_SCRIPT=env.XL_16.1.1_SpectrumMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION
QDP3D_BTAG=${precision}-prec

PKG_SRC=${HAROM_SRC}
PKG_INSTALL=${HAROM_INSTALL}
PKG_DIST=${HAROM_DIST}


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

${PKG_SRC}/configure \
    --prefix=${PKG_INSTALL} \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}" \
    LDFLAGS="-Wl " \
    LIBS="-lrt" \
    --with-hadron=${HADRON_INSTALL} \
    --with-qdp=${QDP3D_INSTALL}/${QDP3D_BTAG} \
    --enable-shmchroma \
    ${OMPENABLE} \
    --host=x86_64-linux-gnu --build=none


${MAKE}
${MAKE} install

popd
