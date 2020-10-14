#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=12
#PBS -N "cutadapt"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR

#------------------------

r1fasta=SRR1658723_1.fastq
r2fasta=${r1fasta/_1/_2}

SAMPLE=mouse10

#------------------------

# Example how FASTA were trimmed to 96 bases

/PATHTO/cutadapt --length 96 --cores=12 -o ${SAMPLE}_96bp_R1.fastq -p ${SAMPLE}_96bp_R2.fastq $r1fasta $r2fasta > ../${SAMPLE}_afterCutadapt.log