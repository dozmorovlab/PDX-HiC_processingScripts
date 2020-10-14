#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=16
#PBS -N "hgReads"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR

mkdir ${SAMPLE}
cd ${SAMPLE}

#------------------------

R1files=/PATHTO/${SAMPLE}/${SAMPLE}_R1.fastq.gz
R2files=${fastqR1/R1/R2}

fname=$(basename $R1files _R1.fastq.gz)

fastaindx=/PATHTO/hg38mm10/hg38mm10.fa
chromToKeep=$PBS_O_WORKDIR/hg38_chromToKeep.bed

#------------------------

# align

/PATHTO/bwa-0.7.17/bwa mem -SP5 -t 16 $fastaindx $R1files $R2files | samblaster | samtools view -Shb -F 2316 - > $fname.bam

# sort and index

file=$fname.bam

samtools sort $file -o ${file%.bam}.sorted.bam
samtools index ${file%.bam}.sorted.bam ${file%.bam}.sorted.bam.bai

samtools flagstat ${file%.bam}.sorted.bam > flagstat.txt

# rm $file

#------------------------

file=${file%.bam}.sorted.bam

# Extract reads mapping to hg38

samtools view -H $file | grep -v "mm10_" > header.txt
samtools view $file -L $chromToKeep -b > ${file%.sorted.bam}.hg38.bam  

# Remove reads with second-pair mapping to mm10 (indicated in column 7):

samtools view ${file%.sorted.bam}.hg38.bam | awk '$7 !~ /mm10_/ {print $0}' | cat header.txt - | samtools view -Sb - > ${file%.sorted.bam}.hg38-only.bam

# rm header.txt
# rm ${file%.sorted.bam}.hg38.bam

# Convert to fastq

bamfile=${file%.sorted.bam}.hg38-only.bam

samtools sort -n $bamfile -o ${bamfile%.bam}.qsort.bam

/PATTHTO/bedtools2/bin/bedtools bamtofastq -i ${bamfile%.bam}.qsort.bam \
                      -fq ${bamfile%-only.bam}_R1.fastq \
                      -fq2 ${bamfile%-only.bam}_R2.fastq

#------------------------

# Count reads - double checking to make sure nothing got lost.

echo "" > fastqReads.txt
echo "Reads written to BAM:" >> fastqReads.txt

samtools view ${bamfile%.bam}.qsort.bam | cut -f1 | perl -nle '$reads{$_}=1;END{print scalar(keys %reads)}' >> fastqReads.txt

echo "" >> fastqReads.txt
echo "Lines in R1 fastq file:" >> fastqReads.txt
wc -l ${bamfile%-only.bam}_R1.fastq >> fastqReads.txt


gzip ${bamfile%-only.bam}_R1.fastq
gzip ${bamfile%-only.bam}_R2.fastq



