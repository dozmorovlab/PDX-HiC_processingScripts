# PDX Hi-C data processing scripts

Scripts to execute various steps in the PDC Hi-C data analysis. 

Scripts were run using PBS job scheduler or in command line.

Each script contains comments about its functionality.

## Genomic annotations

- `0a.refgenie.sh` - download genomic sequences and assets using refgenie
- `0b.make_annotation_folder.sh` - softlink refgeine assets into one folder
- `0c.restriction_sites.sh` - create restriction site BED files

## Manipulate in silico PDX Hi-C data

- `1.fetchdata.sh` - download data from SRA using `sratoolkit`
- `2a.cutadapt.sh` - trim reads to certain length using `cutadapt`
- `2b.gzipFiles.sh` - compress files using `gzip`
- `3.makePDXs.sh` - combine human and mouse reads
- `4a.splitPDXs-xenome.sh` - split human and mouse reads using `xenome`
- `4b.splitPDXs-getHg38Reads.sh` - extract human reads using the combined alignment strategy

## Processing PDX Hi-C data

- `5a.runHiC-Pro` - scripts to run HiC-Pro pipeline
    - `config-system.txt` - an example of configuration file to install HiC-Pro
    - `config_hicpro_hg38.txt` - an example of sample-specific configuration file for HiC-Pro
    - `1.run_HiCPro_hg38.sh` - a script creating the following files using settings from `config_hicpro_hg38.txt`
        - `2.HiCPro_step1_PDX.qsub` - First step of HiC-Pro pipeline
        - `3.HiCPro_step2_PDX.qsub` - Second step of HiC-Pro pipeline
        - `inputfiles_PDX.txt` - List of samples to process. Only "R1" file is necessary

- `5b.runHiCExplorer` - scripts to run HiCExplorer pipeline
    - `run_bwamem_R1.sh` - aligning R1 reads
    - `run_bwamem_R2.sh` - aligning R2 reads
    - `hicBuildMatrix.sh` - run HiCExplorer on the aligned R1 and R2 BAM files

- `5c.runJuicer` - scripts to run Juicer pipeline
    - `setup_folders.sh` - setup folders and softlink raw data for Juicer processing
    - `run_juicer.sh` - run Juicer on the linked data

- `5d.collectResults` - scripts to collect and merge QC metrics from different pipelines
    - `11.hicpro_collectStats.sh` - HiC-Pro stats
    - `12.hicpro_mergeStats.sh`
    - `21.hicexplorer_collectStats.sh` - HiCExplorer stats
    - `22.hicexplorer_mergeStats.sh`
    - `31.juicer_collectStats.sh` - Juicer stats
    - `32.juicer_mergeStats.sh`

## Analysis of processed Hi-C data

- `6.convertFileFormats` - scripts to convert file formats to `.h5`
    - `hicpro_to_h5.sh` - convert HiC-Pro results to `.h5` format
    - `juicer_to_h5` - scripts for step-wise conversion of Juicer results to `.h5` format
        - `1.juicer_to_txt.sh` - convert `.hic` format to text format
        - `2.juicer2hicpro.R` - R script to convert text format to matrix. Called by `3.convert_to_hicpro.qsub`
        - `3.convert_to_hicpro.sh` - convert text format to matrix
        - `4.hicpro_to_h5.sh` - convert and KR normalize matrix to `.h5` format 

- `7.hicPlotDistVsCounts.sh` - estimate distance-dependent decay
- `8.TADs.sh` - TAD calling using `hicFindTADs`

