#!/bin/bash
#
#################
# BUILD QDP
#################

ENV_SCRIPT=env.XL_16.1.1_SpectrumMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

BUILD_TAG=${precision}-prec

PKG_SRC=${QDP_SRC}
PKG_INSTALL=${QDP_INSTALL}/${BUILD_TAG}
PKG_DIST=${QDP_DIST}_${BUILD_TAG}


pushd ${PKG_SRC}
autoreconf
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
    --with-qmp=${QMP_INSTALL} \
    --with-libxml2=${LIBXML2_INSTALL} \
    CXXFLAGS="${PK_CXXFLAGS} -fpermissive" \
    CFLAGS="${PK_CFLAGS}" \
    CXX="${PK_CXX}" \
    CC="${PK_CC}" \
    --host=x86_64-linux-gnu --build=none \
    ${OMPENABLE}

#/bin/xml2-config \

# TBB
# ${PKG_SRC}/configure \
#     --prefix=${PKG_INSTALL} \
#     --enable-parallel-arch=parscalar \
#     --enable-precision="${precision}" \
#     --enable-filedb \
#     --disable-generics \
#     --enable-largefile \
#     --enable-parallel-io \
#     --enable-alignment=64 \
#     --with-qmp=${QMP_INSTALL} \
#     CXXFLAGS="${PK_CXXFLAGS} -fpermissive -I${TBBINCDIR} -g" \
#     CFLAGS="${PK_CFLAGS}" \
#     CXX="${PK_CXX}" \
#     CC="${PK_CC}" \
#     LDFLAGS="-L${TBBLIBDIR}" LIBS="-ltbb -ltbbmalloc -lpthread" \
#     --host=x86_64-linux-gnu --build=none \
#     ${OMPENABLE} \
#     --enable-tbb-pool-allocator

#	--with-libxml2=${LIBXML2_CONFIG}\


${MAKE}
${MAKE} install

popd
