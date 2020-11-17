#!/bin/bash
#
#################
# BUILD QDP-NOJIT
#################

ENV_SCRIPT=env.GCC_8.4.0_SpectrumMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

BUILD_TAG=${precision}-prec

PKG_SRC=${QDP_SRC_GP4}
PKG_INSTALL=${QDP_INSTALL_GP4}/${BUILD_TAG}
PKG_DIST=${QDP_DIST_GP4}_${BUILD_TAG}


pushd ${PKG_SRC}
autoreconf
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


# No TBB
${PKG_SRC}/configure \
    --prefix=${PKG_INSTALL} \
    --enable-parallel-arch=parscalar \
    --enable-precision="${precision}" \
    --enable-filedb \
    --disable-generics \
    --enable-largefile \
    --enable-parallel-io \
    --enable-alignment=64 \
    --enable-layout=cb2 \
    --with-qmp=${QMP_INSTALL_GP4} \
    CXXFLAGS="${PK_CXXFLAGS} -fpermissive" \
    CFLAGS="${PK_CFLAGS}" \
    CXX="${PK_CXX}" \
    CC="${PK_CC}" \
    --with-libxml2=${LIBXML2_INSTALL} \
    --host=x86_64-linux-gnu --build=none \
    ${OMPENABLE}


${MAKE}
${MAKE} install

popd
