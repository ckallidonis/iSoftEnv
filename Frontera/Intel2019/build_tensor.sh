#!/bin/bash
#
#################
# BUILD Tensor
#################


ENV_SCRIPT=env.Intel2019.sh
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
    --with-arpack \
    --host=x86_64-linux-gnu \
    F77="${PK_FF}" \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} ${MKL_INC}" \
    CFLAGS="${PK_CFLAGS} ${MKL_INC}" \
    LDFLAGS="${MKL_LDFLAGS}"  \
    LIBS="${MKL_LINK}" \
    ${OMPENABLE}


#     CXXFLAGS="-I /dist/scidac/atlas/include" \
#     CFLAGS="-I /dist/scidac/atlas/include" \
#     LDFLAGS="-L /dist/scidac/atlas/lib"  \
#     LIBS="-lm -llapack -lcblas -latlas"

#     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  
#     ${OMPENABLE} 

${MAKE}
${MAKE} install

popd
