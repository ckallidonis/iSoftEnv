#!/bin/bash
#
#################
# BUILD Tensor
#################


ENV_SCRIPT=env.XL_16.1.1_SpectrumMPI.sh
source ./${ENV_SCRIPT}

PKG_SRC=${TENSOR_SRC}
PKG_INSTALL=${TENSOR_INSTALL}
PKG_DIST=${TENSOR_DIST}


pushd ${PKG_SRC}
./autogen.sh
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
    --with-backend=essl \
    F77="${PK_FF}" \
    CC="${PK_CC}" \
    CXX="${PK_CXX}" \
    CFLAGS="${PK_CFLAGS} ${ESSL_INC}" \
    CXXFLAGS="${PK_CXXFLAGS} ${ESSL_INC}" \
    LDFLAGS="${ESSL_LDFLAGS}"  \
    LIBS="${ESSL_LINK}" \
    ${OMPENABLE} \
    --host=x86_64-linux-gnu --build=none

#  --with-arpack \

${MAKE}
${MAKE} install

popd
