#!/bin/bash


prog=qmp
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=qdpxx
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=qphix
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=mgproto
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=chroma
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=tensor
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=hadron
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2
 
prog=chroma-devel-genprop
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=adat
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=colorvec
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=qdpxx_3d
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=harom
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"

sleep 2

prog=redstar
echo -e "\n##### Building ${prog} #####\n"
./build_${prog}.sh
echo -e "\n##### ${prog} DONE #####\n"


echo -e "\n\n##### Building all packages completed! #####\n\n"
