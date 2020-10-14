#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1:ppn=1
#PBS -m abe
#PBS -N digestion
#PBS -j oe

cd $PBS_O_WORKDIR

# Folder where annotations are organized
DIR_ANNOTATIONS=/home/mdozmorov/work

cd $DIR_ANNOTATIONS"/annotation/hg38/"
# Phase Genomics restriction sites for hg38 genome
PATHTO/HiC-Pro/bin/utils/digest_genome.py -r ^GATC -o GATC_hg38.bed hg38.fa
# Arima Genomics restriction sites for hg38 genome
wget ftp://ftp-arimagenomics.sdsc.edu/pub/HiCPro_GENOME_FRAGMENT_FILES/hg38_GATC_GANTC.bed

cd $DIR_ANNOTATIONS"/annotation/mm10/"
# Phase Genomics restriction sites for mm10 genome
PATHTO/HiC-Pro/bin/utils/digest_genome.py -r ^GATC -o GATC_mm10.bed mm10.fa
# Arima Genomics restriction sites for mm10 genome
wget ftp://ftp-arimagenomics.sdsc.edu/pub/HiCPro_GENOME_FRAGMENT_FILES/mm10_GATC_GANTC.bed

