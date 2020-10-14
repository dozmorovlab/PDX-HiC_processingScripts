#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=16
#PBS -N "bwaABR1"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR

# Following settings here:
# https://hicexplorer.readthedocs.io/en/latest/content/mES-HiC_analysis.html

Rfiles=/PATHTO/${SAMPLE}/*_R1.fastq.gz

fname=$(basename $Rfiles .fastq.gz)

fastaindx=/PATHTO/hg38/hg38.fa

/PATHTO/bwa-0.7.17/bwa mem -A 1 -B 4 -E 50 -L 0 -t 16 $fastaindx $Rfiles | samtools view -Shb - > $fname.bam

# Collect some statistics

file=$fname.bam

samtools sort $file -o ${file%.bam}.sorted.bam
samtools index ${file%.bam}.sorted.bam ${file%.bam}.sorted.bam.bai

samtools flagstat ${file%.bam}.sorted.bam >> flagstat_info_R1.txt

rm ${file%.bam}.sorted.bam
rm ${file%.bam}.sorted.bam.bai

