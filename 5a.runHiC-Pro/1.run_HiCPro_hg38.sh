#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1:ppn=16
#PBS -m abe
#PBS -N hicpro_hg38
#PBS -j oe
#PBS -q workq

cd $PBS_O_WORKDIR

PATH_TO_RAW_DATA=/PATH_TO_FASTA

PATH_TO_OUTPUT=/PATH_TO_OUTPUT

MY_LOCAL_CONFIG_FILE=/PATHTO/config_hicpro_hg38.txt

/PATHTO/HiC-Pro_2.9.0/bin/HiC-Pro -i $PATH_TO_RAW_DATA -o $PATH_TO_OUTPUT -c $MY_LOCAL_CONFIG_FILE -p 16


