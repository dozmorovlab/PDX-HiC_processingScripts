#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1
#PBS -m abe
#PBS -N juicer2hicpro
#PBS -o /PATHTO/logs/
#PBS -e /PATHTO/logs/
#PBS -q workq

cd $PBS_O_WORKDIR

RESOLUTION_=10000

WD_=$PBS_O_WORKDIR/${SAMPLE}

# Reuse on of the HiC-Pro generated bed files
BED_=/PATHTO/hic_results/matrix/SAMPLE/raw/10000/SAMPLE_10000_abs.bed

RSCRIPT_=$PBS_O_WORKDIR/2.juicer2hicpro.R

FOUT_=${SAMPLE}"_"${RESOLUTION_}"_juicer2hicpro.matrix"

Rscript ${RSCRIPT_} -w=${WD_} -b=${BED_} -o=${FOUT_} 

mv ${SAMPLE}/${FOUT_} Direct/

rm -rf ${SAMPLE}/

