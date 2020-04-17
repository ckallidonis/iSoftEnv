#/bin/bash

# Set up environment

# Set up compilers and compiler flags
DIST_DIRECTORIES=/users/kallidoc/software/util/iSoftEnv/PizDaint/GCC_8.3.0/directories.sh
source ${DIST_DIRECTORIES}

export ENV_PRECISION=double

ulimit -c


# OpenMP
export OMPFLAGS="-fopenmp "
export OMPENABLE="--enable-openmp"

export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++11 "
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "

export PK_CXXFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c++11 "
export PK_CFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c99 "

# Compilers for compiling package (passed as CC to ./configure throghout)
# cc and CC are drivers/wrappers that point to the correct compilers based on the Programming Environment loaded
export PK_FF="/opt/gcc/8.3.0/bin/gfortran"
export PK_CC_SERIAL="/opt/gcc/8.3.0/bin/gcc"
export PK_CXX_SERIAL="/opt/gcc/8.3.0/bin/g++"

export PK_CC="cc"
export PK_CXX="CC"


# CUDA
export PK_CUDA_HOME=${CUDATOOLKIT_HOME}

# GNU / CRAY-MPICH directories
export CRAY_MPI_LIBS=$CRAY_MPICH2_DIR/lib
export CC_LIBS=/opt/gcc/8.3.0/snos/lib64


# QDP-JIT related variables
export QDPJIT_LDFLAGS="${OMPFLAGS} -L${CRAY_MPI_LIBS} -L${LLVM_INSTALL}/lib -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64  -Wl,-rpath=${LLVM_INSTALL}/lib -Wl,-rpath=${PK_CUDA_HOME}/lib64 -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${CRAY_MPI_LIBS} -Wl,-rpath=${CC_LIBS}"
export QDPJIT_LIBS="-ldl -pthread -lmpich -lmpich_gnu_82"
export QDPJIT_INC="-I${CRAY_MPICH2_DIR}/include"

export CHROMA_LIBS="-lcublas -lcudart ${QDPJIT_LIBS}"
export CHROMA_LDFLAGS="${QDPJIT_LDFLAGS}"

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 

export ENV_GCC830=1
