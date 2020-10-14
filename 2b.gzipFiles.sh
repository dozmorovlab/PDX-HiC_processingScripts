#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1
#PBS -m abe
#PBS -N gzip
#PBS -j oe

cd $PBS_O_WORKDIR

DIR_=/PATH_TO_FASTA

graft1=$DIR_/KBM7/KBM7_96bp_R1.fastq 	# SRR1658703 were first trimmed to 96 nt.
graft2=$DIR_/KBM7/SRR1658707_1.fastq

FASTQ_="KBM7_R1.fastq.gz"

cat ${graft1/_R1/_R2} ${graft2/_1/_2} | gzip > ${FASTQ_/_R1/_R2}
gunzip -c ${FASTQ_/_R1/_R2} | wc -l >> read_count.txt