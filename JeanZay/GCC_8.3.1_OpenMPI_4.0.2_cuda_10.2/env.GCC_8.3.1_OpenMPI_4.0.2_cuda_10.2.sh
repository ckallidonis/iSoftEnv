#/bin/bash

# Set up environment
module purge
module load automake/1.16.1
module load gcc/8.3.1
module load openmpi/4.0.2-cuda
module load cuda/10.2
module load cmake/3.14.4

# Set up compilers and compiler flags
DIST_DIRECTORIES=/gpfswork/rech/ual/uie52up/software/util/iSoftEnv/JeanZay/GCC_8.3.1_OpenMPI_4.0.2_cuda_10.2/directories.sh
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
GNU_GCC_DIR=/gpfslocalsup/spack_soft/gcc/8.2.0/gcc-4.8.5-3gf5hj6qpbqqh44sdsnueyyvbnjtbgnh
export CC_LIBS=${GNU_GCC_DIR}/lib64

export PK_FF="${GNU_GCC_DIR}/bin/gfortran"

export PK_CC="mpicc"
export PK_CXX="mpic++"

export PK_CMAKE=cmake


# CUDA
export PK_CUDA_HOME=${CUDA_HOME}
export SM=sm_70


# PATH / LD_LIBRARY_PATH
export PATH=${LLVM_INSTALL}/bin:${GNU_GCC_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${PK_CUDA_HOME}/nvvm/lib64:${CC_LIBS}:${LD_LIBRARY_PATH}
echo $LD_LIBRARY_PATH


#LLVM
export QDPJIT_HOST_ARCH="all"
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
