#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1
#PBS -m abe
#PBS -N prefetch
#PBS -j oe
#PBS -q workq

cd $PBS_O_WORKDIR

export PATH=$PATH:/PATHTO/sratoolkit.2.9.6-1-centos_linux64/bin/

# Example how HMEC data were downloaded

SAMPLE=SRR1658680 # HMEC, HIC058
id=HMEC

prefetch $SAMPLE --max-size 100G > $SAMPLE"_"$id.log

fastq-dump --split-files $SAMPLE