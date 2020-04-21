#/bin/bash

# Set up environment

# Set up compilers and compiler flags
DIST_DIRECTORIES=/work/04587/kallidoc/frontera/software/util/iSoftEnv/Frontera/MVAPICH2-GNU/directories.sh
source ${DIST_DIRECTORIES}

export ENV_PRECISION=double

ulimit -c


# OpenMP
export OMPFLAGS="-fopenmp "
export OMPENABLE="--enable-openmp"

export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++11 "
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=gnu99 "

export PK_CXXFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c++11 "
export PK_CFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=gnu99 "

# Compilers for compiling package (passed as CC to ./configure throghout)
# cc and CC are drivers/wrappers that point to the correct compilers based on the Programming Environment loaded
export PK_FF="/opt/apps/gcc/8.3.0/bin/gfortran"
export PK_CC_SERIAL="/opt/apps/gcc/8.3.0/bin/gcc"
export PK_CXX_SERIAL="/opt/apps/gcc/8.3.0/bin/g++"

export PK_CC="/opt/apps/intel19/mvapich2/2.X/bin/mpicc"
export PK_CXX="/opt/apps/intel19/mvapich2/2.X/bin/mpic++"

export PK_CMAKE=/opt/apps/cmake/3.16.1/bin/cmake


# CUDA
export PK_CUDA_HOME=${TACC_CUDA_DIR}
export SM=sm_60

# GNU / CRAY-MPICH directories
export MPI_LIBS=$MPI_ROOT/lib64
export CC_LIBS=/opt/apps/gcc/8.3.0/lib64

# PATH / LD_LIBRARY_PATH
export PATH=${LLVM_INSTALL}/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${PK_CUDA_HOME}/nvvm/lib64:${CC_LIBS}:${MPI_LIBS}:${LD_LIBRARY_PATH}
echo $LD_LIBRARY_PATH

#LLVM
export LLVM_CXXFLAGS="-O3 -std=c++11"
export LLVM_CXXFLAGS="-O3 -std=c99"


# QDP-JIT related variables
export QDPJIT_LDFLAGS="${OMPFLAGS} -L${MPI_LIBS} -L${LLVM_INSTALL}/lib -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64  -Wl,-rpath=${LLVM_INSTALL}/lib -Wl,-rpath=${PK_CUDA_HOME}/lib64 -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${MPI_LIBS} -Wl,-rpath=${CC_LIBS}"
export QDPJIT_LIBS="-ldl -pthread -lmpich"
export QDPJIT_INC="-I${MPI_ROOT}/include"

export CHROMA_LIBS="-lcublas -lcudart ${QDPJIT_LIBS}"
export CHROMA_LDFLAGS="${QDPJIT_LDFLAGS}"

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 

export ENV_GCC830=1
