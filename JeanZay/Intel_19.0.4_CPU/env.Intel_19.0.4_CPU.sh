#/bin/bash

# Set up environment
module purge
module load intel-all
module load cmake/3.14.4


# Set up compilers and compiler flags
DIST_DIRECTORIES=/gpfswork/rech/ual/uie52up/software/util/iSoftEnv/JeanZay/Intel_19.0.4_CPU/directories.sh
source ${DIST_DIRECTORIES}

ulimit -c

# Precision env. variables
export ENV_PRECISION=double
export ENV_QPHIX_SOALEN=4
export ENV_QPHIX_INNER_SOALEN=8


# Python
export PYTHON_DIR=/gpfslocalsup/pub/anaconda-py3/2019.03

# OpenMP
export OMPFLAGS="-qopenmp "
export OMPENABLE="--enable-openmp"

JZ_MKL_INC=${MKLROOT}/include
JZ_MKL_LIB=${MKLROOT}/lib/intel64


export MKL_INC=" -I${JZ_MKL_INC}"
export MKL_LDFLAGS=" -L${JZ_MKL_LIB}"
if test "X${OMPFLAGS}X" == "XX";
then
    export MKL_LINK=" -Wl,--start-group ${JZ_MKL_LIB}/libmkl_intel_lp64.a ${JZ_MKL_LIB}/libmkl_core.a ${JZ_MKL_LIB}/libmkl_sequential.a -Wl,--end-group -lpthread -lm"
else
    # Threaded Libs
    export  MKL_LINK=" -Wl,--start-group ${JZ_MKL_LIB}/libmkl_intel_lp64.a ${JZ_MKL_LIB}/libmkl_core.a ${JZ_MKL_LIB}/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm"
fi

echo "MKL INCLUDE FLAGS:" $MKL_INC
echo "MKL LDFLAGS......:" $MKL_LDFLAGS
echo "MKL LINK FLAGS...:" $MKL_LINK


export PK_QPHIX_ISA="avx512"
export PK_KOKKOS_HOST_ARCH="SKL"
#ARCHFLAGS=" -march=knl "
ARCHFLAGS=" -xCORE-AVX512 "
export PK_AVX_VERSION="AVX512"

#PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 -stdlib=libc++ -Drestrict=__restrict__ "${ARCHFLAGS}
export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "${ARCHFLAGS}" "

export PK_CXXFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c99 "${ARCHFLAGS}" "

# Compilers for compiling package (passed as CC to ./configure throghout) 
export PK_FF="ifort"
export PK_CC="mpiicc"
export PK_CXX="mpiicpc"

export PK_HOST_CXX=icpc
export PK_HOST_CXXFLAGS="-g -O3 -std=c++11 "

#PK_HOST_CXX=clang++
#PK_HOST_CXXFLAGS="-g -O3 -std=c++11 -stdlib=libc++"

#GNU Wrappers
#PK_CC=mpicc
#PK_CXX=mpicxx
#PK_CC="mpicc -cc=icc "
#PK_CXX="mpicxx -CC=icpc "


# cmake
#export CMAKE=/home/kallidoc/work_JLabLQCD/software/install/Intel_19.0.4_CPU_LatestDevel/cmake-3.15.4/bin/cmake

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 
#export MAKE="make" 

export ENV_INTEL2019=1
