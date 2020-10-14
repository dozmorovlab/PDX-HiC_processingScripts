
# https://stackoverflow.com/questions/1729824/an-efficient-way-to-transpose-a-file-in-bash

#---------------------

strategyName=combined

DIRSTATS_=/PATH_TO_TOOL-LOGS_DIRECTORY/
pdxType="name"

#---------------------

DIROUT_=/OUTPUT_DIRECTORY/

#--------------------------------------

cd $DIRSTATS_

FILES=*/*_binSizeQCs/QC_table.txt

for file in $FILES
do

SAMPLE=$(dirname $(dirname $file))

sed 's/ /_/g' $file > ${file%.txt}.undrsc.txt

awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' ${file%.txt}.undrsc.txt | awk '{print $1,$2}' OFS="\t" > $DIROUT_/$SAMPLE.stats.txt

rm ${file%.txt}.undrsc.txt

done

#--------------------------------------

cd $DIROUT_/

paste *.stats.txt | cut -f1,2,4,6,8,10,12 > ${pdxType}_${strategyName}_hicExplorer.txt

rm *.stats.txt


