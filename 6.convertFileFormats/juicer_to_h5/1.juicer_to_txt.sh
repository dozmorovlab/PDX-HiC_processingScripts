#!/bin/bash
#PBS -S /bin/bash
#PBS -V
#PBS -l nodes=1
#PBS -m abe
#PBS -N juicer2hicpro
#PBS -o /PATHTO/logs/
#PBS -e /PATHTO/logs/
#PBS -q workq
#PBS -J 1-25

cd $PBS_O_WORKDIR

mkdir -p ${SAMPLE}
cd ${SAMPLE}

echo ${SAMPLE}
echo

echo -n 'Job is running on node '; head -n 1 $PBS_NODEFILE
echo

#--------------------------

juicerFILE_=/PATHTO/${SAMPLE}/aligned/inter_30.hic
         
#--------------------------

# https://github.com/aidenlab/juicer/wiki/Data-Extraction

array=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 M X Y)

i=$(expr $PBS_ARRAY_INDEX - 1)

chrom=${array[$i]}

RESOLUTION_=10000

OUTFILE_="chrom_"$chrom"_"${SAMPLE}"_"${RESOLUTION_}.txt

java -jar juicer_tools_1.13.02.jar dump observed NONE ${juicerFILE_} $chrom $chrom BP ${RESOLUTION_} ${OUTFILE_}


