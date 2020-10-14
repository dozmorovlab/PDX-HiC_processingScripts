#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1
#PBS -N "distPlot"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR

echo -n 'Job is running on node '; head -n 1 $PBS_NODEFILE
echo

source activate HiCExplorer
export HDF5_USE_FILE_LOCKING='FALSE'

#--------------------------

FILES_=/JuicerResults/*GM12878*/KR_corrected.h5

hicPlotDistVsCounts -m ${FILES_} \
        -o GM12878_Juicer.png \
        --labels 'GM12878 (0%)' 'GM12878 (10%)' 'GM12878 (30%)' \
        --maxdepth 20000000 \
	      --outFileData GM12878_Juicer.txt \
        --plotsize 6 5

