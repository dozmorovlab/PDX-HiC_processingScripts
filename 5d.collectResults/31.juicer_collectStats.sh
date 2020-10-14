#!/bin/bash

#****************************************************

PDXtype=$1
FOLDER=$2

echo 'sh' $0 $1 $2 >> 30.juicer_cmdRun.txt

OUTjuicer=${PDXtype}-juicerStats.txt

qc_metrics_temp=juicer_outs_temp.txt

#****************************************************

for folder in $FOLDER/*/
do
	fname=$(basename $folder)

	qc_metrics=${fname%_v1}_juicer_outs.txt

	statfile=$FOLDER/$fname/aligned/inter_30.txt

	echo -e "Sample\nnReads\nnPaired\nnChimeric\nnChimericAmb\nunmapped\nligation\nalignable\nunique\npcrDupl\nintraFragment\nlowMapQ\nHiC\nhic3bias\nhicL\nhicI\nhicO\nhicR\ninterReads\nshortReads\nlongReads" > $qc_metrics

	tempCol=tempCol.txt

	nReads=($(grep "Sequenced Read Pairs:" $statfile))
	nPaired=($(grep "Normal Paired:" $statfile))
	nChimeric=($(grep "Chimeric Paired:" $statfile))
	nChimericAmb=($(grep "Chimeric Ambiguous:" $statfile))
	unmapped=($(grep "Unmapped:" $statfile))
	ligation=($(grep "Ligation Motif Present:" $statfile))
	alignable=($(grep "Alignable (Normal+Chimeric Paired):" $statfile))

	unique=($(grep "Unique Reads:" $statfile))
	pcrDupl=($(grep "PCR Duplicates:" $statfile))

	intraFragment=($(grep "Intra-fragment Reads:" $statfile))
	lowMapQ=($(grep "Below MAPQ Threshold:" $statfile))

	nHiC=($(grep "Hi-C Contacts:" $statfile))
	hic3bias=($(grep "3' Bias (Long Range):" $statfile))
	hicPairType=($(grep "Pair Type %(L-I-O-R):" $statfile))

	ninterReads=($(grep "Inter-chromosomal:" $statfile))
	nshortReads=($(grep "Short Range (<20Kb):" $statfile))
	nlongReads=($(grep "Long Range (>20Kb):" $statfile))

	echo -e "${fname%_v1}\n${nReads[3]}\n${nPaired[2]}\n${nChimeric[2]}\n${nChimericAmb[2]}\n${unmapped[1]}\n${ligation[3]}\n${alignable[3]}\n${unique[2]}\n${pcrDupl[2]}\n${intraFragment[2]}\n${lowMapQ[3]}\n${nHiC[2]}\n${hic3bias[4]}\n${hicPairType[3]}\n${hicPairType[5]}\n${hicPairType[7]}\n${hicPairType[9]}\n${ninterReads[1]}\n${nshortReads[3]}\n${nlongReads[3]}" >> $tempCol

	paste $qc_metrics $tempCol > $qc_metrics_temp
	mv $qc_metrics_temp $qc_metrics

	rm $tempCol

done

paste *_juicer_outs.txt | awk '{print $1,$2,$4,$6,$8,$10,$12}' OFS="\t" > $OUTjuicer

rm *_juicer_outs.txt


