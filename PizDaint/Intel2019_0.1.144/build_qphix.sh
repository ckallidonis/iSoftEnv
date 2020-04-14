#!/bin/bash
#
#################
# BUILD QPHIX
#################

ENV_SCRIPT=env.Intel2019_0.1.144.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

QDP_BTAG=${precision}-prec

BUILD_TAG=${precision}-prec_${PK_QPHIX_ISA}

PKG_SRC=${QPHIX_SRC}
PKG_INSTALL=${QPHIX_INSTALL}/${BUILD_TAG}
PKG_DIST=${QPHIX_DIST}_${BUILD_TAG}

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



CC="${PK_CC}" \
    CFLAGS="${PK_CFLAGS} " \
    CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} " \
    cmake \
    -Disa=${PK_QPHIX_ISA} \
    -G"Eclipse CDT4 - Unix Makefiles" \
    -Dhost_cxx=${PK_HOST_CXX} \
    -Dhost_cxxflags="${PK_HOST_CXXFLAGS}" \
    -Drecursive_jN=${PK_TARGET_JN} \
    -DCMAKE_INSTALL_PREFIX=${PKG_INSTALL} \
    -DQDPXX_DIR=${QDP_INSTALL}/${QDP_BTAG} \
    -DQMP_DIR=${QMP_INSTALL} \
    -Dclover=TRUE \
    -Dtm_clover=TRUE \
    -Dcean=FALSE \
    -Dqdpalloc=FALSE \
    -Dqdpjit=FALSE \
    -Dtesting=TRUE \
    -DPYTHON_EXECUTABLE=/usr/bin/python3.6 \
    -DPYTHON_INCLUDE_DIR=/usr/bin/include \
    -DPYTHON_LIBRARY=/usr/lib \
    ${PKG_SRC}

#   -Drecursive_jN=${PK_TARGET_JN} \
 

#    LDFLAGS="${PK_LDFLAGS}" \
#    LIBS="${PK_LIBS}" \


#    -Dparallel_arch=parscalar \
#    -Dqdpalloc=TRUE \
#    -Dmm_malloc=FALSE \

#make
#make install
${MAKE}
${MAKE} install

popd
