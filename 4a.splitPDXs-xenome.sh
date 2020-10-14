#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1:ppn=10
#PBS -m abe
#PBS -N Xenome
#PBS -j oe
#PBS -q workq

cd $PBS_O_WORKDIR

# Instructions on how to run the tool: https://github.com/data61/gossamer/blob/master/docs/xenome.md
# /opt/tools/gossamer_1.0.0/bin/xenome index -M 100 -T 16 -P idx -H /home/sequencing/juicer/HiC-Pro_2.9.0/annotation/mm10/mm10.fa -G /home/sequencing/juicer/HiC-Pro_2.9.0/annotation/hg38/hg38.fa

fastqR1=/PATHTO/${SAMPLE}/${SAMPLE}_R1.fastq.gz

fastqR2=${fastqR1/R1/R2}

mkdir ${SAMPLE}

/opt/tools/gossamer_1.0.0/bin/xenome classify -l ${SAMPLE}/${SAMPLE}.log -T 10 --pairs -i $fastqR1 -i $fastqR2 -M 20 -P /PATHTO/indx-Xenome/idx --graft-name hg38 --host-name mm10 --output-filename-prefix ${SAMPLE}/${SAMPLE} >> ${SAMPLE}/${SAMPLE}"-info.log"