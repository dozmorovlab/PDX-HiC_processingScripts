#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=8
#PBS -N "hicexplorer"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR

source activate HiCExplorer
export HDF5_USE_FILE_LOCKING='FALSE'

bampath=/PATHTO/${SAMPLE}     # Set a path to R1 and R2 alignments 

BAMR1=$bampath/${SAMPLE}*_R1.bam
BAMR2=$bampath/${SAMPLE}*_R2.bam

restrfile=/PATHTO/GATC_hg38.bed # This file was made with hicFindRestSite tool on hg38 reference genome using GATC as a restriction site.

# calc contact matrix based on specified binsize

hicBuildMatrix -s $BAMR1 $BAMR2 \
               --binSize 10000 \
	             --restrictionSequence GATC \
	             --danglingSequence GATC \
               --QCfolder ${SAMPLE}_binSizeQCs \
               --threads 8 \
               --outBam ${SAMPLE}_binSize.bam \
               --outFileName ${SAMPLE}_binSize.h5 \
               -rs $restrfile \
               --inputBufferSize 400000



