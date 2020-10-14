#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1:ppn=16
#PBS -N "tads"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR

echo ${SAMPLE}
echo

echo -n 'Job is running on node '; head -n 1 $PBS_NODEFILE
echo

source activate HiCExplorer
export HDF5_USE_FILE_LOCKING='FALSE'

mkdir -p ${SAMPLE}
cd ${SAMPLE}

#--------------------------

FILE_=KR_corrected.h5

#--------------------------
# TADs detection
#--------------------------

hicFindTADs -m ${FILE_} \
        --outPrefix juicer \
        --minDepth 30000 \
        --maxDepth 100000 \
        --step 10000 \
        --thresholdComparisons 0.05 \
        --delta 0.01 \
        --correctForMultipleTesting fdr \
        -p 16

#--------------------------
# Plot TADs (Matplotlib must be > 3.1.1)
#--------------------------

hicPlotTADs --tracks TADs-plotsettings.ini --region chr18:3000000-5500000 -o TAD_calling_plot.png

#--------------------------

hicPlotMatrix -m ${FILE_} \
        --region chr18:1000000-8000000 \
        --title ${SAMPLE} \
        --clearMaskedBins \
        --dpi 300 \
        --outFileName chr18_plot.png
