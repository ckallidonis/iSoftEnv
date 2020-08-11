#!/bin/bash


prog=llvm
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=libxml2
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=qmp
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=qdp_jit
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=quda
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=chroma
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"


echo -e "\n\n##### Building all packages completed! #####\n\n"
