#/bin/bash

# Set up environment

# Set up compilers and compiler flags
DIST_DIRECTORIES=/home/04587/kallidoc/software/util/iSoftEnv/Longhorn/GCC_7.3.0_SpectrumMPI/directories.sh
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
export PK_FF="/opt/apps/gcc/7.3.0/bin/gfortran"
export PK_CC_SERIAL="/opt/apps/gcc/7.3.0/bin/gcc"
export PK_CXX_SERIAL="/opt/apps/gcc/7.3.0/bin/g++"

export PK_CC=/opt/ibm/spectrum_mpi/bin/mpicc
export PK_CXX=/opt/ibm/spectrum_mpi/bin/mpicxx


# CUDA
export PK_CUDA_HOME=${TACC_CUDA_DIR}
export SM=sm_70

# GNU / Spectrum-MPI directories
export SPECTRUM_MPI_LIBS=${TACC_SPECTRUM_MPI_LIB}
export CC_LIBS=/opt/apps/gcc/7.3.0/lib64

export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${PK_CUDA_HOME}/nvvm/lib64:${CC_LIBS}:${SPECTRUM_MPI_LIBS}:${LD_LIBRARY_PATH}
echo $LD_LIBRARY_PATH

#LLVM
export LLVM_CXXFLAGS="-O3 -std=c++11"
export LLVM_CXXFLAGS="-O3 -std=c99"



# QDP-JIT related variables
export QDPJIT_LDFLAGS="${OMPFLAGS} -L${SPECTRUM_MPI_LIBS} -L${LLVM_INSTALL}/lib -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64  -Wl,-rpath=${LLVM_INSTALL}/lib -Wl,-rpath=${PK_CUDA_HOME}/lib64 -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${SPECTRUM_MPI_LIBS} -Wl,-rpath=${CC_LIBS}"
export QDPJIT_LIBS="-ldl -pthread"
# -lmpich -lmpich_gnu_82"
export QDPJIT_INC="-I${TACC_SPECTRUM_MPI_INC}"
export QDPJIT_HOST_ARCH="PowerPC;NVPTX"

export CHROMA_LIBS="-lcublas -lcudart ${QDPJIT_LIBS}"
export CHROMA_LDFLAGS="${QDPJIT_LDFLAGS}"

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 

export ENV_GCC830=1
