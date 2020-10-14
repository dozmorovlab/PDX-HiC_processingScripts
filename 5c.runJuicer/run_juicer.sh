#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1
#PBS -m abe
#PBS -N juicer
#PBS -j oe
#PBS -q workq

cd $PBS_O_WORKDIR

dFOLDER=/OUTPUT_DIRECTORY/$SAMPLE

export PATH=$PATH:/PATHTO/bwa-0.7.17/

/PATHTO/juicedir/scripts/juicer.sh -g hg38 -d $dFOLDER -s "Sau3AI" \
	-D /PATHTO/juicedir \
	-z /PATHTO/hg38.fa \
	-p /PATHTO/hg38.chrom.sizes \
	-y /PATHTO/GATC_hg38.bed


