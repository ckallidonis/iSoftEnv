#/bin/bash

# Set up environment

# Set up compilers and compiler flags
DIST_DIRECTORIES=/users/kallidoc/software/util/iSoftEnv/PizDaint/GCC_8.3.0/directories.sh
source ${DIST_DIRECTORIES}

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
export PK_CC="/opt/gcc/8.3.0/bin/gcc"
export PK_CXX="/opt/gcc/8.3.0/bin/g++"

export CC_LIBS=/opt/gcc/8.3.0/snos/lib64

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 

export ENV_GCC830=1
