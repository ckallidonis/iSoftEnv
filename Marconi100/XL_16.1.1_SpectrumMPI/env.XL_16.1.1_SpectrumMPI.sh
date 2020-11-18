#/bin/bash

# Set up environment
module load spectrum_mpi
module load xl/16.1.1--binary
#module load cuda/10.2
module load cmake/3.17.1
module load essl/6.2.1--binary

# Set up compilers and compiler flags
DIST_DIRECTORIES=/m100/home/userexternal/ckallido/software/util/iSoftEnv/Marconi100/XL_16.1.1_SpectrumMPI/directories.sh
source ${DIST_DIRECTORIES}

ulimit -c

# Precision env. variables
export ENV_PRECISION=double
export ENV_QPHIX_SOALEN=4
export ENV_QPHIX_INNER_SOALEN=8


# OpenMP
export OMPFLAGS="-fopenmp "
export OMPENABLE="--enable-openmp"


export ESSL_INC=" -I${ESSL_INCLUDE} "
export ESSL_LDFLAGS=" -L${ESSL_LIB}"
if test "X${OMPFLAGS}X" == "XX";
then
    export ESSL_LINK=" ${ESSL_LDFLAGS} -lessl"
else
    # Threaded Libs
    export  ESSL_LINK=" ${ESSL_LDFLAGS} -lesslsmp"
fi

echo "ESSL INCLUDE FLAGS:" $ESSL_INC
echo "ESSL LDFLAGS......:" $ESSL_LDFLAGS
echo "ESSL LINK FLAGS...:" $ESSL_LINK

export PK_ARCH_TAG="pwr9"
export ARCHFLAGS=" -qarch=${PK_ARCH_TAG} "

#PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 -stdlib=libc++ -Drestrict=__restrict__ "${ARCHFLAGS}
export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "${ARCHFLAGS}" "

export PK_CXXFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c++14 "${ARCHFLAGS}
export PK_CFLAGS_NOOPT=${OMPFLAGS}"-O3 -std=c99 "${ARCHFLAGS}" "

# Compilers for compiling package (passed as CC to ./configure throughout) 
export PK_FF="mpixlf"
export PK_CC="mpixlc"
export PK_CXX="mpixlC"

export PK_HOST_CXX=xlc_r
export PK_HOST_CXXFLAGS="-g -O3 -std=c++14 "


# CUDA
export PK_CUDA_HOME=/cineca/prod/opt/compilers/cuda/10.1/none
export SM=sm_70

export QUDA_LDFLAGS="${OMPFLAGS} -L${PK_CUDA_HOME}/lib64 -L${PK_CUDA_HOME}/nvvm/lib64 -Wl,-rpath=${PK_CUDA_HOME}/lib64  -Wl,-rpath=${PK_CUDA_HOME}/nvvm/lib64"


export LD_LIBRARY_PATH=$LIBXML2_INSTALL/lib:${LD_LIBRARY_PATH}

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 
export PK_CMAKE=/cineca/prod/opt/tools/cmake/3.17.1/none/bin/cmake
