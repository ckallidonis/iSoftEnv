#!/bin/bash
#
#################
# BUILD Tensor
#################


ENV_SCRIPT=env.GCC_8.4.0_SpectrumMPI.sh
source ./${ENV_SCRIPT}

PKG_SRC=${TENSOR_SRC_GP4}
PKG_INSTALL=${TENSOR_INSTALL_GP4}
PKG_DIST=${TENSOR_DIST_GP4}


pushd ${PKG_SRC}
autoreconf -f -i
#./autogen.sh
popd
pushd ${BUILDDIR_GP4}

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
    CC="${PK_CC} ${LA_INC}" \
    CXX="${PK_CXX} ${LA_INC}" \
    CFLAGS="${PK_CFLAGS} ${LA_INC}" \
    CXXFLAGS="${PK_CXXFLAGS} ${LA_INC}" \
    LDFLAGS="${LA_LDFLAGS}"  \
    LIBS="${LA_LINK}" \
    ${OMPENABLE} \
    --host=x86_64-linux-gnu --build=none


#  --with-arpack \

${MAKE}
${MAKE} install

popd
