
# run the script with the command:
# sh 22.hicexplorer_mergeStats.sh xenome filtered_hicExplorer.txt

PDXtype=$1

paste *${PDXtype}*.txt | awk '{print $1,$7,$8,$2,$3,$4,$5}' OFS="\t" > $2

rm *${PDXtype}*.txt



