#!/bin/bash
#
#################
# BUILD Adat
#################

ENV_SCRIPT=env.Intel2019.sh
source ./${ENV_SCRIPT}

PKG_SRC=${ADAT_PDF_SRC}
PKG_INSTALL=${ADAT_PDF_INSTALL}
PKG_DIST=${ADAT_PDF_DIST}


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
    CXXFLAGS="${PK_CXXFLAGS_NOOPT} -I/usr/include ${MKL_INC}" \
    LDFLAGS="-L/usr/lib64 ${MKL_LDFLAGS}"  LIBS="${MKL_LINK} -lgmpxx -lgmp" \
    --host=x86_64-linux-gnu --build=none \
    ${OMPENABLE}

#    CXXFLAGS="${PK_CXXFLAGS} -I/usr/include ${MKL_INC}" \
#    LDFLAGS="-L/usr/lib64 ${MKL_LDFLAGS}"  LIBS="${MKL_LINK} -lgmpxx -lgmp" \

${MAKE}
${MAKE} install

popd
