#!/bin/bash
#
#################
# BUILD LIBXML2
#################

ENV_SCRIPT=env.MVAPICH2-GNU.sh
source ./${ENV_SCRIPT}

PKG_SRC=${LIBXML2_SRC}
PKG_INSTALL=${LIBXML2_INSTALL}
PKG_DIST=${LIBXML2_DIST}

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


${PKG_SRC}/configure --prefix=${PKG_INSTALL} -host=x86_64-unknown-linux \
    --build=x86_64-suse-linux \
    CC="${PK_CC}" \
    CFLAGS="${PK_CFLAGS}" \
    --disable-shared \
    --without-zlib \
    --without-python \
    --without-readline \
    --without-threads \
    --without-history \
    --without-reader \
    --without-writer \
    --with-output \
    --without-ftp \
    --without-http \
    --without-pattern \
    --without-catalog \
    --without-docbook \
    --without-iconv \
    --without-schemas \
    --without-schematron \
    --without-modules \
    --without-xptr \
    --without-xinclude


${MAKE}
${MAKE} install

popd
