#/bin/bash

# Set up environment

#module unload python2/2.7.16
#module load python3/3.7.0

# Set up compilers and compiler flags
DIST_DIRECTORIES=/users/kallidoc/software/util/iSoftEnv/PizDaint/Intel2019_0.1.144/directories.sh
source ${DIST_DIRECTORIES}

ulimit -c

# Precision env. variables
export ENV_PRECISION=double
export ENV_QPHIX_SOALEN=4
export ENV_QPHIX_INNER_SOALEN=8


# OpenMP
export OMPFLAGS="-fopenmp "
export OMPENABLE="--enable-openmp"

PD_MKL_INC=${MKLROOT}/include
PD_MKL_LIB=${MKLROOT}/lib/intel64_lin

export MKL_INC=" -I${PD_MKL_INC}"
export MKL_LDFLAGS=" -L${PD_MKL_LIB}"
if test "X${OMPFLAGS}X" == "XX";
then
    export MKL_LINK=" -Wl,--start-group ${PD_MKL_LIB}/libmkl_intel_lp64.a ${PD_MKL_LIB}/libmkl_core.a ${PD_MKL_LIB}/libmkl_sequential.a -Wl,--end-group -lpthread -lm"
else
    # Threaded Libs
    export MKL_LINK=" -Wl,--start-group ${PD_MKL_LIB}/libmkl_intel_lp64.a ${PD_MKL_LIB}/libmkl_core.a ${PD_MKL_LIB}/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm"
fi

echo "MKL INCLUDE FLAGS:" $MKL_INC
echo "MKL LDFLAGS......:" $MKL_LDFLAGS
echo "MKL LINK FLAGS...:" $MKL_LINK

#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PD_MKL_LIB}


export PK_QPHIX_ISA="avx2"
export PK_KOKKOS_HOST_ARCH="SKL"
#ARCHFLAGS=" -march=knl "
ARCHFLAGS=" -xCORE-AVX2 "
export PK_AVX_VERSION="AVX2"

#PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 -stdlib=libc++ -Drestrict=__restrict__ "${ARCHFLAGS}
export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "${ARCHFLAGS}" "

export PK_CXXFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c99 "${ARCHFLAGS}" "

# Compilers for compiling package (passed as CC to ./configure throghout)
# cc and CC are drivers/wrappers that point to the correct compilers based on the Programming Environment loaded
export PK_FF="ifort"
export PK_CC="cc"
export PK_CXX="CC"

# Tensor package needs explicitly the compilers
export TENSOR_PK_CC=icc
export TENSOR_PK_CXX=icpc

export PK_HOST_CXX=icpc
export PK_HOST_CXXFLAGS="-g -O3 -std=c++11 "


# CUDA
PK_CUDA_HOME=${CUDATOOLKIT_HOME}
export SM=sm_60


# cmake
export PK_CMAKE=/users/kallidoc/software/install/Intel2019_0.1.144_devel/cmake-3.17.1/bin/cmake


# GNU-GCC (might be needed...)
GNU_GCC_DIR=/opt/gcc/8.3.0/snos
CC_LIBS=${GNU_GCC_DIR}/lib64

# PATH / LD_LIBRARY_PATH
export PATH=${GNU_GCC_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${PK_CUDA_HOME}/nvvm/lib64:${PK_CUDA_HOME}/lib64:${CC_LIBS}:${LD_LIBRARY_PATH}


# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 
#export MAKE="make" 

export ENV_INTEL2019=1
