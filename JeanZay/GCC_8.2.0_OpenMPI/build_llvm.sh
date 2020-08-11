#!/bin/bash
#
#################
# BUILD LLVM
#################

ENV_SCRIPT=env.GCC_8.2.0_OpenMPI.sh
source ./${ENV_SCRIPT}

PKG_SRC=${LLVM_SRC}
PKG_INSTALL=${LLVM_INSTALL}
PKG_DIST=${LLVM_DIST}

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


cmake -G "Unix Makefiles" \
      -DCMAKE_CXX_FLAGS="${LLVM_CXXFLAGS}" \
      -DCMAKE_CXX_COMPILER=${PK_CXX_LLVM} \
      -DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${CC_LIBS} -L${CC_LIBS}" \
      -DLLVM_ENABLE_TERMINFO="OFF" \
      -DCMAKE_C_COMPILER=${PK_CC_LLVM} \
      -DCMAKE_C_FLAGS="${LLVM_CFLAGS}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${PKG_INSTALL} \
      -DLLVM_TARGETS_TO_BUILD=${QDPJIT_HOST_ARCH} \
      -DLLVM_ENABLE_ZLIB="OFF" \
      -DBUILD_SHARED_LIBS="ON" \
      -DLLVM_ENABLE_RTTI="ON"  \
      ${PKG_SRC}



${MAKE}
${MAKE} install

popd
