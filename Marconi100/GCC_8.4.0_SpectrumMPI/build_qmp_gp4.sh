#!/bin/bash
#
#################
# BUILD QMP
#################

ENV_SCRIPT=env.GCC_8.4.0_SpectrumMPI.sh
source ./${ENV_SCRIPT}

PKG_SRC=${QMP_SRC_GP4}
PKG_INSTALL=${QMP_INSTALL_GP4}
PKG_DIST=${QMP_DIST_GP4}


pushd ${PKG_SRC}
autoreconf
popd
pushd ${BUILDDIR_GP4}

BUILD_FILES_DIST=build_${QMP_DIST_GP4}

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
    LDFLAGS="${LDFLAGS_GP4}" \
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
