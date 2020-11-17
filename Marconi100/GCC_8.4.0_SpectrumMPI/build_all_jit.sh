#!/bin/bash

for prog in llvm_jit libxml2_jit qmp_jit qdp_jit quda_jit chroma_jit
do
    echo -e "\n##### Building ${prog} #####\n"
    ./build_${prog}.sh
    echo -e "\n##### ${prog} DONE #####\n"

    sleep 2
done

echo -e "\n\n##### Building all packages completed! #####\n\n"
