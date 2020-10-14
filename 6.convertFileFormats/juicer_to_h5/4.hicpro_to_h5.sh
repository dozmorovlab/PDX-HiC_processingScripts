#!/bin/bash
#PBS -S /bin/bash
#PBS -l nodes=1
#PBS -N "hicproTOh5"
#PBS -j oe
#PBS -q workq
#PBS -V

cd $PBS_O_WORKDIR/Direct/

echo ${SAMPLE}
echo

echo -n 'Job is running on node '; head -n 1 $PBS_NODEFILE
echo

source $HOME/Tools/anaconda/bin/activate
export HDF5_USE_FILE_LOCKING='FALSE'

#--------------------------

hicproFILE_=/PATHTO/${SAMPLE}_10000_juicer2hicpro.matrix

# Reuse one of the HiC-Pro generated bed files
hicproBEDFILE_=/PATHTO/hic_results/matrix/SAMPLE/raw/10000/SAMPLE_10000_abs.bed

#--------------------------

fname=$(basename ${hicproFILE_} .matrix)

convertedFILE_=$fname".hicpro.h5"

#--------------------------
# Convert HiC-Pro matrices to h5 matrices
#--------------------------

hicConvertFormat --matrices ${hicproFILE_} --outFileName ${convertedFILE_} --inputFormat hicpro --outputFormat h5 --bedFileHicpro ${hicproBEDFILE_}

#--------------------------
# Correct matrix
#--------------------------

mkdir -p ${SAMPLE}

mv ${convertedFILE_} ${SAMPLE}/

cd ${SAMPLE}

correctedFILE_="KR_corrected.h5"

#--------------------------

hicCorrectMatrix correct --matrix ${convertedFILE_} --correctionMethod KR --perchr -o ${correctedFILE_}

#--------------------------



