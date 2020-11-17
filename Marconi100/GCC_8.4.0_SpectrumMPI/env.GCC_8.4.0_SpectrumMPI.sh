#/bin/bash

# Set up environment
module purge
module load spectrum_mpi
module load gnu/8.4.0
#module load cuda/10.2
module load essl/6.2.1--binary
module load cmake/3.17.1


# Set up compilers and compiler flags
DIST_DIRECTORIES_JIT=/m100/home/userexternal/ckallido/software/util/iSoftEnv/Marconi100/GCC_8.4.0_SpectrumMPI/directories_jit.sh
DIST_DIRECTORIES_GP4=/m100/home/userexternal/ckallido/software/util/iSoftEnv/Marconi100/GCC_8.4.0_SpectrumMPI/directories_gp4.sh
source ${DIST_DIRECTORIES_JIT}
source ${DIST_DIRECTORIES_GP4}

export ENV_PRECISION=double

ulimit -c

# OpenMP
export OMPFLAGS="-fopenmp "
export OMPENABLE="--enable-openmp"


# Linear Algebra libraries
#export LA_INC="-I/cineca/prod/opt/compilers/xl/16.1.1/binary/xlf/16.1.1/include -I/cineca/prod/opt/compilers/xl/16.1.1/binary/xlC/16.1.1/include -I/cineca/prod/opt/compilers/xl/16.1.1/binary/xlsmp/5.1.1/include -I${ESSL_INCLUDE}  "
export LA_INC=" -I${ESSL_INCLUDE}  "
export LA_LDFLAGS="-Wl,-rpath-link,/cineca/prod/opt/compilers/xl/16.1.1/binary/xlf/16.1.1/lib -Wl,-rpath-link,/cineca/prod/opt/compilers/xl/16.1.1/binary/xlsmp/5.1.1/lib -Wl,-rpath-link,/cineca/prod/opt/compilers/xl/16.1.1/binary/xlC/16.1.1/lib -Wl,-rpath-link,/cineca/prod/opt/compilers/xl/16.1.1/binary/lib -L${ESSL_LIB} -L/cineca/prod/opt/compilers/xl/16.1.1/binary/xlC/16.1.1/lib -L/cineca/prod/opt/compilers/xl/16.1.1/binary/xlf/16.1.1/lib -L/cineca/prod/opt/compilers/xl/16.1.1/binary/xlsmp/5.1.1/lib -L/cineca/prod/opt/compilers/xl/16.1.1/binary/lib"
export LA_LIBS=" -lessl"
export LA_LIBS_THR=" -lesslsmp"

export LA_LIBPATH="${ESSL_LIB}:/cineca/prod/opt/compilers/xl/16.1.1/binary/xlsmp/5.1.1/lib:/cineca/prod/opt/compilers/xl/16.1.1/binary/xlf/16.1.1/lib:/cineca/prod/opt/compilers/xl/16.1.1/binary/xlC/16.1.1/lib"



# LAPACK_LIB=/cineca/prod/opt/libraries/lapack/3.9.0/gnu--8.4.0/lib
# LAPACK_INC=/cineca/prod/opt/libraries/lapack/3.9.0/gnu--8.4.0/include
# BLAS_LIB=/cineca/prod/opt/libraries/blas/3.8.0/gnu--8.4.0/lib

# export LA_INC=" -I${OPENBLAS_INCLUDE} -I${LAPACK_INC}"
# export LA_LDFLAGS=" -L${OPENBLAS_LIB} -L${LAPACK_LIB} -L${BLAS_LIB}"
# export LA_LIBS="-lopenblas -llapack -lblas"
# export LA_LIBS_THR="-lopenblas -llapack -lblas"

# export LA_LIBPATH="${OPENBLAS_LIB}:${LAPACK_LIB}:${BLAS_LIB}"

if test "X${OMPFLAGS}X" == "XX";
then
    export LA_LINK=" ${LA_LDFLAGS} ${LA_LIBS}"
else
    # Threaded Libs
    export  LA_LINK=" ${LA_LDFLAGS} ${LA_LIBS_THR}"
fi

echo "LA INCLUDE FLAGS:" $LA_INC
echo "LA LDFLAGS......:" $LA_LDFLAGS
echo "LA LINK FLAGS...:" $LA_LINK
#--------------------------------------------

export PK_ARCH_TAG="pwr9"
export ARCHFLAGS=
" -qarch=${PK_ARCH_TAG} "


export PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++11 "${ARCHFLAGS}
export PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "${ARCHFLAGS}

# Compilers for compiling package (passed as CC to ./configure throghout)
# cc and CC are drivers/wrappers that point to the correct compilers based on the Programming Environment loaded
GNU_GCC_DIR=/cineca/prod/opt/compilers/gnu/8.4.0/none
export CC_LIBS=${GNU_GCC_DIR}/lib64

export PK_FF="/cineca/prod/opt/compilers/spectrum_mpi/10.3.1/binary/bin/mpif77"

export PK_CC="mpicc"
export PK_CXX="mpic++"

export PK_CMAKE=/cineca/prod/opt/tools/cmake/3.17.1/none/bin/cmake


# CUDA
#export PK_CUDA_HOME=${CUDA_ROOT}
export PK_CUDA_HOME=/cineca/prod/opt/compilers/cuda/10.1/none
#/cineca/prod/opt/compilers/cuda/10.1/none
#
export PK_CUDA_BIN=${PK_CUDA_HOME}/bin
export PK_CUDA_LIB=${PK_CUDA_HOME}/lib64
export PK_CUDA_NVVM_LIB=${PK_CUDA_HOME}/nvvm/lib64
 
export SM=sm_70


# PATH / LD_LIBRARY_PATH
export PATH=${LLVM_INSTALL}/bin:${PK_CUDA_BIN}:${GNU_GCC_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${PK_CUDA_NVVM_LIB}:${PK_CUDA_LIB}:${CC_LIBS}:${LA_LIBPATH}:${LD_LIBRARY_PATH}
echo $PATH
echo $LD_LIBRARY_PATH

#LLVM
export QDPJIT_HOST_ARCH="PowerPC;NVPTX"
export PK_CC_LLVM="${GNU_GCC_DIR}/bin/gcc"
export PK_CXX_LLVM="${GNU_GCC_DIR}/bin/g++"
export LLVM_CXXFLAGS="-O3 -std=c++11"
export LLVM_CFLAGS="-O3 -std=c99"


# QDP-JIT related variables
export LDFLAGS_JIT="${OMPFLAGS} -L${LLVM_INSTALL}/lib -L${PK_CUDA_LIB} -L${PK_CUDA_NVVM_LIB}  -Wl,-rpath=${LLVM_INSTALL}/lib -Wl,-rpath=${PK_CUDA_LIB}  -Wl,-rpath=${PK_CUDA_NVVM_LIB} -Wl,-rpath=${CC_LIBS}"
export LIBS_JIT="-ldl -pthread" # -lmpich -lmpich_gnu_82"
export JIT_INC=""

LDFLAGS_GP4="${OMPFLAGS} -L${PK_CUDA_LIB} -L${PK_CUDA_NVVM_LIB} -Wl,-rpath=${PK_CUDA_LIB}  -Wl,-rpath=${PK_CUDA_NVVM_LIB}"

# Make
PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 
