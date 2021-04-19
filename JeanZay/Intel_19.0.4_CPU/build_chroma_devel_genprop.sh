#!/bin/bash
#
#################
# BUILD Chroma-devel-genprop
#################

ENV_SCRIPT=env.Intel_19.0.4_CPU.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION
QPHIX_SOALEN=$ENV_QPHIX_SOALEN
QPHIX_INNER_SOALEN=$ENV_QPHIX_INNER_SOALEN

BUILD_TAG=${precision}-prec_${PK_QPHIX_ISA}_soalen${QPHIX_SOALEN}

QDP_BTAG=${precision}-prec
QPHIX_BTAG=${precision}-prec_${PK_QPHIX_ISA}
MGPROTO_BTAG=${precision}-prec_${PK_QPHIX_ISA}_soalen${QPHIX_SOALEN}

PKG_SRC=${CHROMA_GENPROP_SRC}
PKG_INSTALL=${CHROMA_GENPROP_INSTALL}/${BUILD_TAG}
PKG_DIST=${CHROMA_GENPROP_DIST}_${BUILD_TAG}

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
    --with-qdp=${QDP_INSTALL}/${QDP_BTAG} \
    --with-qmp=${QMP_INSTALL} \
    --with-hadron=${HADRON_INSTALL} \
    ${OMPENABLE} \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS="${PK_CXXFLAGS} " CFLAGS="${PK_CFLAGS} " \
    LDFLAGS="-Wl,-zmuldefs " LIBS="" \
    --with-qphix-solver=${QPHIX_INSTALL}/${QPHIX_BTAG} \
    --enable-qphix-solver-arch=${PK_QPHIX_ISA} \
    --enable-qphix-solver-soalen=${QPHIX_SOALEN} \
    --enable-qphix-solver-compress12 \
    --enable-qphix-solver-inner-type=f \
    --enable-qphix-solver-inner-soalen=${QPHIX_INNER_SOALEN} \
    --with-mg-proto=${MGPROTO_INSTALL}/${MGPROTO_BTAG} \
    --host=x86_64-linux-gnu --build=none \
    --enable-static-packed-gauge \
    --enable-fused-clover-deriv-loops



#    --enable-cpp-wilson-dslash --enable-sse2 \

${MAKE}
${MAKE} check

#  LDFLAGS="-Wl,-zmuldefs  -L${VTUNELIBDIR} -L${TBBINCDIR}" LIBS=" -ltbb -ltbbmalloc -littnotify -lpthread" \

${MAKE} install

#       --with-qmp=${INSTALLDIR}/qmp \
#        --with-qphix-solver=${INSTALLDIR}/dslash-avx-s4 \
#        --enable-qphix-solver-arch=avx512 \
#        --enable-qphix-solver-soalen=4 \
#        --enable-qphix-solver-compress12 \
#       --enable-qphix-solver-inner-type=f \
#        --enable-qphix-solver-inner-soalen=4 \
# --enable-sse-scalarsite-bicgstab-kernels   \
popd
