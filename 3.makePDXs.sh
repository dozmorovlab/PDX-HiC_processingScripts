#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1
#PBS -m abe
#PBS -N merging
#PBS -j oe

cd $PBS_O_WORKDIR

DIR_=/PATH_TO_FASTA

# Example of how 'HMEC (10%)' was constructed

graft=$DIR_/HMEC/SRR1658680_1.fastq
host=$DIR_/M10/SRR1658718_1.fastq

PDX_="PDX10_HMEC_R1.fastq.gz"

cat $graft $host | gzip > ${PDX_}
cat ${graft/_1/_2} ${host/_1/_2} | gzip > ${PDX_/_R1/_R2}