#!/bin/bash
#
#################
# BUILD Chroma
#################

ENV_SCRIPT=env.GCC_8.2.0_OpenMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

BUILD_TAG=${precision}-prec

QDPJIT_BTAG=${precision}-prec

PKG_SRC=${CHROMA_SRC}
PKG_INSTALL=${CHROMA_INSTALL}/${BUILD_TAG}
PKG_DIST=${CHROMA_DIST}_${BUILD_TAG}

pushd ${PKG_SRC}
autoreconf
popd

pushd ${BUILDDIR}

BUILD_FILES_DIST=build_${PKG_DIST}

if [ -d ${BUILD_FILES_DIST} ]; 
then 
  rm -rf ${BUILD_FILES_DIST}
  sleep 2
fi

mkdir  ${BUILD_FILES_DIST}
cd ${BUILD_FILES_DIST}


if [ -d ${PKG_INSTALL} ]; 
then 
  rm -rf ${PKG_INSTALL}
fi
mkdir -p ${PKG_INSTALL}

####
#  DISABLE C++ Dslash because of include file conflicts
###
${PKG_SRC}/configure --prefix=${PKG_INSTALL} \
    --with-qdp=${QDPJIT_INSTALL}/${QDPJIT_BTAG} \
    --with-qmp=${QMP_INSTALL_GNU} \
    ${OMPENABLE} \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} " CFLAGS="${PK_CFLAGS} " \
    LDFLAGS="${JIT_LDFLAGS} " \
    LIBS="-lcublas -lcudart ${JIT_LIBS}" \
    --enable-jit-clover \
    --host=x86_64-linux-gnu --build=none \
    --with-cuda=${PK_CUDA_HOME} \
    --enable-quda-deviface \
    --with-quda=${QUDA_INSTALL}


${MAKE}
${MAKE} check

${MAKE} install

popd
