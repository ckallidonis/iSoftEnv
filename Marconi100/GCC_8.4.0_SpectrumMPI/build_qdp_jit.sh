#!/bin/bash
#
#################
# BUILD QDP-JIT
#################

ENV_SCRIPT=env.GCC_8.4.0_SpectrumMPI.sh
source ./${ENV_SCRIPT}

precision=$ENV_PRECISION

BUILD_TAG=${precision}-prec

PKG_SRC=${QDPJIT_SRC}
PKG_INSTALL=${QDPJIT_INSTALL}/${BUILD_TAG}
PKG_DIST=${QDPJIT_DIST}_${BUILD_TAG}


pushd ${PKG_SRC}

echo "Cleaning QDP-JIT LibDeviceSipport"
rm -rf ./libdevice_files
rm -f ./include/qdp_libdevice.h
rm -f ./lib/qdp_libdevice.cc
echo "QDP-JIT adding LibDevice patch"
mkdir -p ./libdevice_files

case ${SM} in
sm_30|sm_35)
  echo "SM30 or SM35 Applying Patch for SQRT nonsense" 
  cd ./libdevice_files
  ../patch_libdevice.sh ${PK_CUDA_HOME}/nvvm/libdevice  ${LLVM_INSTALL_DIR}
  cd ..
;;
*)
 echo "Not SM30 nor SM35. Copying LibDevice Files"
  cp ${PK_CUDA_HOME}/nvvm/libdevice/* ./libdevice_files
;;
esac

echo "After potential patching libdevice_files contains the following:"
ls ./libdevice_files

echo "Moving the right libdevice file to libdevice.bc" 

# Enter Libdevice files in source directory
pushd ./libdevice_files

CUDA_MAJOR=`nvcc --version | grep release | awk '{ print $6}' | cut -f2 -dV | cut -f1 -d.`
echo "CUDA MAJOR is: ${CUDA_MAJOR}"
case ${CUDA_MAJOR} in
7|8)
      echo CUDA v7 or 8.
      case ${SM} in
      sm_30)
        LIBDEVICE_FILE="libdevice.compute_30.10.bc"
        ;;
      sm_35)
        # Use SM_35 Libdevice file
        LIBDEVICE_FILE="libdevice.compute_35.10.bc"
        ;;
      sm_37)
        # Use SM_35 Libdevice file
        LIBDEVICE_FILE="libdevice.compute_35.10.bc"
        ;;
      sm_5*)
        # Use SM_50 libdevice file
        LIBDEVICE_FILE="libdevice.compute_50.10.bc"
        ;;
      sm_6*)
        # Use SM_30 Libdevice file for SM_60 (Kate told me this)
        LIBDEVICE_FILE="libdevice.compute_30.10.bc"
        ;;
      *)
        echo "That I dont know which libdevice file to use for that ${SM}"
        echo "For SMs more recent than SM_60, please use CUDA-9 or better"
        exit -1
        ;;
      esac
      echo "SM is ${SM} : Copying ${LIBDEVICE_FILE} to ./libdevice.bc"
      cp ${LIBDEVICE_FILE} libdevice.bc
      ;;
*) 
      echo CUDA v9. Copying libdevice.10.bc to libdevice.bc
      mv libdevice.10.bc libdevice.bc
      ;;
esac
popd ## libdevice_files

./pack_libdevice.sh ./libdevice_files

### Check the packed libdevice.bc
pushd ./libdevice_files
echo "Disassembling the libdevice.bc file with llvm-dis"
${LLVM_INSTALL}/bin/llvm-dis < libdevice.bc > disassembled_libdevicebc
lines=`grep "rsqrt\.approx\.ftz\.f64" disassembled_libdevicebc | wc -l`
echo "Bad Lines in libdevice.bc: "$lines
echo "Check Done"
popd

popd

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


echo $LD_LIBRARY_PATH

${PKG_SRC}/configure \
          --prefix=${PKG_INSTALL} \
          --with-libxml2=${LIBXML2_INSTALL_GNU} \
          --with-qmp=${QMP_INSTALL} \
          --enable-comm-split-deviceinit \
          --enable-parallel-arch=parscalar \
          --enable-precision="${precision}" \
          --enable-largefile \
          --enable-parallel-io \
          --enable-dml-output-buffering \
          --enable-llvm8 \
          --disable-generics \
          --enable-filedb \
          --with-cuda=${PK_CUDA_HOME} \
          --with-llvm=${LLVM_INSTALL} \
          CXXFLAGS="${PK_CXXFLAGS} ${JIT_INC}" \
          CFLAGS="${PK_CFLAGS} ${JIT_INC}" \
          LDFLAGS="${JIT_LDFLAGS}" \
          LIBS="${JIT_LIBS}" \
          CXX="${PK_CXX}" \
          CC="${PK_CC}" \
          --host=x86_64-linux-gnu --build=none \
          ${OMPENABLE}


${MAKE}
${MAKE} install

popd
