#/bin/bash

# Set up environment
COMPILER_SUITE=/dist/intel/parallel_studio_2019/parallel_studio_xe_2019

# export VTUNE=${COMPILER_SUITE}/vtune_amplifier_2019
# export TBBLIBDIR=${COMPILER_SUITE}/compilers_and_libraries_2019/linux/tbb/lib/intel64/gcc4.7
# export TBBINCDIR=${COMPILER_SUITE}/compilers_and_libraries_2019/linux/tbb/include
# export VTUNEINCDIR=$VTUNE/include
# export VTUNELIBDIR=$VTUNE/lib64
source  ${COMPILER_SUITE}/psxevars.sh intel64
#${VTUNE}/apsvars.sh --vtune

# export GCC_VERSION="6.3.0"
# module load gcc-${GCC_VERSION}

export PYTHON_ROOT=/home/bjoo/Python3

export PATH=${PYTHON_ROOT}/bin:$PATH:
export LD_LIBRARY_PATH=${PYTHON_ROOT}/lib:${PYTHON_ROOT}/lib/python3.6:$LD_LIBRARY_PATH:


# Set up compilers and compiler flags
DIST_DIRECTORIES=/home/kallidoc/work_JLabLQCD/software/install/iSoftEnv/JLab-KNL/Intel2019/directories.sh
source ${DIST_DIRECTORIES}


# Precision env. variables
export ENV_PRECISION=double
export ENV_QPHIX_SOALEN=4
export ENV_QPHIX_INNER_SOALEN=8


# OpenMP
export OMPFLAGS="-qopenmp "
export OMPENABLE="--enable-openmp"

if test "X${MKLROOT}X" == "XX";
then
    export MKL_INC=""
    export MKL_LINK=""
else
    export MKL_INC=" -I${MKLROOT}/include"
    export MKL_LDFLAGS=" -L${MKLROOT}/lib/intel64"
    if test "X${OMPFLAGS}X" == "XX";
    then
	export MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group -lpthread -lm"
    else
	# Threaded Libs
	export  MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm"
    fi
fi

echo "MKL INCLUDE FLAGS:" $MKL_INC
echo "MKL LINK FLAGS:" $MKL_LINK
echo "MKL LDFLAGS:" $MKL_LDFLAGS


export PK_QPHIX_ISA="avx512"
export PK_KOKKOS_HOST_ARCH="KNL"
#ARCHFLAGS=" -march=knl "
ARCHFLAGS=" -xMIC-AVX512 "
export PK_AVX_VERSION="AVX512"

#PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 -stdlib=libc++ -Drestrict=__restrict__ "${ARCHFLAGS}
export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "${ARCHFLAGS}" "

# Compilers for compiling package (passed as CC to ./configure throghout) 
export PK_FF="ifort"
export PK_CC="mpiicc"
export PK_CXX="mpiicpc"

export PK_HOST_CXX=mpiicpc
export PK_HOST_CXXFLAGS="-g -O3 -std=c++11 "

#PK_HOST_CXX=clang++
#PK_HOST_CXXFLAGS="-g -O3 -std=c++11 -stdlib=libc++"

#GNU Wrappers
#PK_CC=mpicc
#PK_CXX=mpicxx
#PK_CC="mpicc -cc=icc "
#PK_CXX="mpicxx -CC=icpc "


# cmake
#export CMAKE=/home/kallidoc/work_JLabLQCD/software/install/Intel2019_LatestDevel/cmake-3.15.4/bin/cmake

# Make
PK_TARGET_JN="12"
export MAKE="make -j ${PK_TARGET_JN}" 

export ENV_INTEL2019=1
