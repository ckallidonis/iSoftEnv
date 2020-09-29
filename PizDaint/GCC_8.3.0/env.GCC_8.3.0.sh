#/bin/bash

# Set up environment
module load gcc/8.3.0
module load cudatoolkit/10.2.89_3.28-7.0.2.1_2.17__g52c0314

# Set up compilers and compiler flags
DIST_DIRECTORIES=/users/kallidoc/software/util/iSoftEnv/PizDaint/GCC_8.3.0/directories.sh
source ${DIST_DIRECTORIES}

export ENV_PRECISION=double

ulimit -c


# OpenMP
export OMPFLAGS="-fopenmp "
export OMPENABLE="--enable-openmp"

export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 "
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "

# Compilers for compiling package (passed as CC to ./configure throghout)
# cc and CC are drivers/wrappers that point to the correct compilers based on the Programming Environment loaded
GNU_GCC_DIR=/opt/gcc/8.3.0/snos
export CC_LIBS=${GNU_GCC_DIR}/lib64

export PK_FF="/opt/gcc/8.3.0/bin/gfortran"

export PK_CC="cc"
export PK_CXX="CC"

export PK_CMAKE=/users/kallidoc/software/install/GCC_8.3.0/cmake-3.17.1/bin/cmake


# CUDA
export PK_CUDA_HOME=${CUDATOOLKIT_HOME}
export SM=sm_60


# PATH / LD_LIBRARY_PATH
export PATH=${LLVM_INSTALL}/bin:/opt/gcc/8.3.0/snos/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${PK_CUDA_HOME}/nvvm/lib64:${CC_LIBS}:${LD_LIBRARY_PATH}
echo $LD_LIBRARY_PATH


#LLVM
export PK_CC_LLVM="${GNU_GCC_DIR}/bin/gcc"
export PK_CXX_LLVM="${GNU_GCC_DIR}/bin/g++"
export LLVM_CXXFLAGS="-O3 -std=c++11"
export LLVM_CFLAGS="-O3 -std=c99"


# QDP-JIT related variables
export JIT_LDFLAGS="${OMPFLAGS} -L${LLVM_INSTALL}/lib -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64  -Wl,-rpath=${LLVM_INSTALL}/lib -Wl,-rpath=${PK_CUDA_HOME}/lib64  -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${CC_LIBS}"
export JIT_LIBS="-ldl -pthread" # -lmpich -lmpich_gnu_82"
export JIT_INC=""

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 

export ENV_GCC830=1
