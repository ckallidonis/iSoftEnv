#!/bin/bash
#
#################
# BUILD Redstar
#################

ENV_SCRIPT=env.Intel_19.0.4_CPU.sh
source ./${ENV_SCRIPT}

PKG_SRC=${REDSTAR_SRC}
PKG_INSTALL=${REDSTAR_INSTALL}
PKG_DIST=${REDSTAR_DIST}


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
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} " \
    --with-hadron=${HADRON_INSTALL} \
    --with-adat=${ADAT_INSTALL} \
    --host=x86_64-linux-gnu --build=none \
    ${OMPENABLE}

${MAKE}
${MAKE} install

popd
