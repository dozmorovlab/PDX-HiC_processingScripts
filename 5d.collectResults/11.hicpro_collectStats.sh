#!/bin/bash

#----------------------------------------------------

PDXtype=$1
FOLDER=$2

echo 'sh' $0 $1 $2 >> cmdRun.txt

OUTmapstat=${PDXtype}-mapstat.txt
OUTpairstat=${PDXtype}-pairstat.txt
OUTmergestat=${PDXtype}-mergestat.txt
OUTRSstat=${PDXtype}-RSstat.txt

#----------------------------------------------------

mapstatSuffix="*_R1_hg38.mapstat"
pairstatSuffix="*.bwt2pairs.pairstat"
mergestatSuffix="_allValidPairs.mergestat"
RSstatSuffix="*_hg38.bwt2pairs.RSstat"


qc_metrics_temp=temp.txt

#----------------------------------------------------

for folder in $FOLDER/logs/*/; do

	foldername=$(basename $folder)

	qc_metrics=$foldername"_mapping_statistics.txt"

	echo -e "Sample\nTotal\nMapped\nGlobal\nLocal" > $qc_metrics

	tempCol=$foldername"_tempCol.txt"

	#************
	# Collect stats from the first alignment round
	#************

	file1=$FOLDER/bowtie_results/bwt2/${foldername}/${foldername}${mapstatSuffix}
	file2=$FOLDER/bowtie_results/bwt2/${foldername}/${foldername}${mapstatSuffix/R1/R2}	

	total=($(grep "total" $file1))

	mapped1=($(grep "mapped" $file1))
	mapped2=($(grep "mapped" $file2))

	global1=($(grep "global" $file1))
	global2=($(grep "global" $file2))

	local1=($(grep "local" $file1))
        local2=($(grep "local" $file2))

	#************

	mappedSUM=`echo "${mapped1[1]}+${mapped2[1]}" | bc`
	globalSUM=`echo "${global1[1]}+${global2[1]}" | bc`
	localSUM=`echo "${local1[1]}+${local2[1]}" | bc`

	echo -e "$foldername\n${total[1]}\n${mappedSUM}\n${globalSUM}\n${localSUM}" >> $tempCol

        paste $qc_metrics $tempCol > $qc_metrics_temp
        mv $qc_metrics_temp $qc_metrics

        rm -r $tempCol

done

paste *"_mapping_statistics.txt" | cut -f1,2,4,6,8,10,12 > $OUTmapstat

rm *"_mapping_statistics.txt" 


#----------------------------------------------------
# Second set of stats

qc_metrics_temp=temp.txt

#----------------------------------------------------

for folder in $FOLDER/logs/*/; do

	foldername=$(basename $folder)

	qc_metrics=$foldername"_pairstat.txt"

	echo -e "Sample\nTotal_pairs_processed\nUnmapped_pairs\nUnique_paired_alignments\nMultiple_pairs_alignments\nPairs_with_singleton\nReported_pairs" > $qc_metrics

	tempCol=$foldername"_tempCol.txt"

	#************
	# Collect stats
	#************

	pairstatFile=$FOLDER/bowtie_results/bwt2/$foldername/${foldername}${pairstatSuffix}

	pairsProcessed=($(grep "Total_pairs_processed" $pairstatFile))	
	unmapped=($(grep "Unmapped_pairs" $pairstatFile))
	uniqPairedAlign=($(grep "Unique_paired_alignments" $pairstatFile))
	mltplPairsAlign=($(grep "Multiple_pairs_alignments" $pairstatFile))
	pairsWithSingl=($(grep "Pairs_with_singleton" $pairstatFile))
	reportedPairs=($(grep "Reported_pairs" $pairstatFile))

	echo -e "$foldername\n${pairsProcessed[1]}\n${unmapped[1]}\n${uniqPairedAlign[1]}\n${mltplPairsAlign[1]}\n${pairsWithSingl[1]}\n${reportedPairs[1]}" >> $tempCol

        paste $qc_metrics $tempCol > $qc_metrics_temp
        mv $qc_metrics_temp $qc_metrics

        rm -r $tempCol

done

paste *"_pairstat.txt" | cut -f1,2,4,6,8,10,12 > $OUTpairstat

rm *"_pairstat.txt" 


#----------------------------------------------------
# Third set of stats

qc_metrics_temp=temp.txt

#----------------------------------------------------

for folder in $FOLDER/logs/*/; do

	foldername=$(basename $folder)

	qc_metrics=$foldername"_mergestat.txt"

	echo -e "Sample\nvalid_interaction\nvalid_interaction_rmdup\ntrans_interaction\ncis_interaction\ncis_shortRange\ncis_longRange" > $qc_metrics

	tempCol=$foldername"_tempCol.txt"

	#************
	# Collect stats from the first alignment round
	#************

	file=$FOLDER/hic_results/data/${foldername}/${foldername}${mergestatSuffix}	

	valid=($(grep "valid_interaction" $file))
	validrmdup=($(grep "valid_interaction_rmdup" $file))
	trans=($(grep "trans_interaction" $file))
	cis=($(grep "cis_interaction" $file))
	short=($(grep "cis_shortRange" $file))
	long=($(grep "cis_longRange" $file))

	echo -e "$foldername\n${valid[1]}\n${validrmdup[1]}\n${trans[1]}\n${cis[1]}\n${short[1]}\n${long[1]}" >> $tempCol

        paste $qc_metrics $tempCol > $qc_metrics_temp
        mv $qc_metrics_temp $qc_metrics

        rm -r $tempCol

done

paste *"_mergestat.txt" | cut -f1,2,4,6,8,10,12 > $OUTmergestat

rm *"_mergestat.txt" 

#----------------------------------------------------
# Fourth set of stats

qc_metrics_temp=temp.txt

#----------------------------------------------------

for folder in $FOLDER/logs/*/; do

	foldername=$(basename $folder)

	qc_metrics=$foldername"_RSstat.txt"

	echo -e "Sample\nValid_interaction_pairs\nValid_interaction_pairs_FF\nValid_interaction_pairs_RR\nValid_interaction_pairs_RF\nValid_interaction_pairs_FR\nDangling_end_pairs\nReligation_pairs\nSelf_Cycle_pairs\nSingle-end_pairs\nDumped_pairs" > $qc_metrics

	tempCol=$foldername"_tempCol.txt"

	#************
	# Collect stats from the first alignment round
	#************

	file=$FOLDER/hic_results/data/${foldername}/${foldername}${RSstatSuffix}

	valid=($(grep "Valid_interaction_pairs" $file))
	validFF=($(grep "Valid_interaction_pairs_FF" $file))
	validRR=($(grep "Valid_interaction_pairs_RR" $file))
	validRF=($(grep "Valid_interaction_pairs_RF" $file))
	validFR=($(grep "Valid_interaction_pairs_FR" $file))
	dangling=($(grep "Dangling_end_pairs" $file))
	religation=($(grep "Religation_pairs" $file))
	self=($(grep "Self_Cycle_pairs" $file))
	send=($(grep "Single-end_pairs" $file))
	dumped=($(grep "Dumped_pairs" $file))

	#************

	echo -e "$foldername\n${valid[1]}\n${validFF[1]}\n${validRR[1]}\n${validRF[1]}\n${validFR[1]}\n${dangling[1]}\n${religation[1]}\n${self[1]}\n${send[1]}\n${dumped[1]}" >> $tempCol

        paste $qc_metrics $tempCol > $qc_metrics_temp
        mv $qc_metrics_temp $qc_metrics

        rm -r $tempCol

done

paste *"_RSstat.txt" | cut -f1,2,4,6,8,10,12 > $OUTRSstat

rm *"_RSstat.txt" 







