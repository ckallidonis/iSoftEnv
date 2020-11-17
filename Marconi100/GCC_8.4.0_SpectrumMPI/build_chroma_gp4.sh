#!/bin/bash
#
#################
# BUILD Chroma
#################

ENV_SCRIPT=env.GCC_8.4.0_SpectrumMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

BUILD_TAG=${precision}-prec_${PK_ARCH_TAG}

QDP_BTAG=${precision}-prec

PKG_SRC=${CHROMA_SRC_GP4}
PKG_INSTALL=${CHROMA_INSTALL_GP4}/${BUILD_TAG}
PKG_DIST=${CHROMA_DIST_GP4}_${BUILD_TAG}

pushd ${PKG_SRC}
autoreconf
popd

pushd ${BUILDDIR_GP4}

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
${PKG_SRC}/configure \
    --prefix=${PKG_INSTALL} \
    --enable-shmharom \
    --with-qdp=${QDP_INSTALL_GP4}/${QDP_BTAG} \
    --with-qmp=${QMP_INSTALL_GP4} \
    ${OMPENABLE} \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} " CFLAGS="${PK_CFLAGS} " \
    LDFLAGS=" " LIBS="-lrt" \
    --host=x86_64-linux-gnu --build=none \
    --with-cuda=${PK_CUDA_HOME} \
    --with-quda=${QUDA_INSTALL_GP4}

#LIBS="${PK_CHROMA_LIBS}" \
 
#    --enable-cpp-wilson-dslash --enable-sse2 \

${MAKE}
${MAKE} check

${MAKE} install

popd
