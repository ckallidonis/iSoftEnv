#!/bin/bash
#
#################
# BUILD QMP
#################

ENV_SCRIPT=env.Intel_19.0.4_CPU.sh
source ./${ENV_SCRIPT}

PKG_SRC=${QMP_SRC}
PKG_INSTALL=${QMP_INSTALL}
PKG_DIST=${QMP_DIST}


pushd ${PKG_SRC}
autoreconf
popd
pushd ${BUILDDIR}

BUILD_FILES_DIST=build_${QMP_DIST}

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
    CC="${PK_CC}" \
    CFLAGS="${PK_CFLAGS}" \
    --host=x86_64-linux-gnu \
    --build=none \
    --with-qmp-comms-type=MPI \
    --with-qmp-comms-cflags="" \
    --with-qmp-comms-ldflags="" \
    --with-qmp-comms-libs=""


    # --with-qmp-comms-cflags=-I/dist/intel/parallel_studio_2019/compilers_and_libraries_2019.0.117/linux/mpi/intel64/include \
    # --with-qmp-comms-ldflags=-L/dist/intel/parallel_studio_2019/compilers_and_libraries_2019.0.117/linux/mpi/intel64/lib \
    # --with-qmp-comms-libs=-lmpi
    

${MAKE}

${MAKE} install

popd
