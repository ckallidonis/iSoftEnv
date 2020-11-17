#!/bin/bash
#
#################
# BUILD Chroma
#################

ENV_SCRIPT=env.XL_16.1.1_SpectrumMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

BUILD_TAG=${precision}-prec_${PK_ARCH_TAG}

QDP_BTAG=${precision}-prec

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
${PKG_SRC}/configure \
    --prefix=${PKG_INSTALL} \
    --enable-shmharom \
    --with-qdp=${QDP_INSTALL}/${QDP_BTAG} \
    --with-qmp=${QMP_INSTALL} \
    ${OMPENABLE} \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} -I${LIBXML2_INSTALL/include} " CFLAGS="${PK_CFLAGS}  -I${LIBXML2_INSTALL/include}" \
    LDFLAGS="-Wl  -L${LIBXML2_INSTALL/lib} " LIBS="-lxml2" \
    --host=x86_64-linux-gnu --build=none \
    --with-cuda=${PK_CUDA_HOME} \
    --with-quda=${QUDA_INSTALL_GCC}

#LIBS="${PK_CHROMA_LIBS}" \
 
#    --enable-cpp-wilson-dslash --enable-sse2 \

${MAKE}
${MAKE} check

${MAKE} install

popd
