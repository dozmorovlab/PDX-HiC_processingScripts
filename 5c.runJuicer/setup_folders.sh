#!/bin/bash

# Each FASTA should be grouped by SAMPLE in a separate folder
FOLDERS=/PATH_TO_FASTA/*/

OUT_=/OUTPUT_DIRECTORY/

for folder in $FOLDERS
do
	cd $OUT_

	name=$(basename $folder)

	mkdir ${name}
	cd ${name}

	mkdir fastq
	cd fastq

	ln -s $folder/*R1.fastq.gz ${name}_R1.fastq.gz
	ln -s $folder/*R2.fastq.gz ${name}_R2.fastq.gz

done

