# PATHTO/annotations should contain the following structure
# .
# ├── hg38
# │   ├── GATC_hg38.bed
# │   ├── hg38.1.bt2
# │   ├── hg38.2.bt2
# │   ├── hg38.3.bt2
# │   ├── hg38.4.bt2
# │   ├── hg38.chrom.sizes
# │   ├── hg38.fa
# │   ├── hg38_GATC_GANTC.bed
# │   ├── hg38.rev.1.bt2
# │   ├── hg38.rev.2.bt2
# │   └── README.md
# ├── hg38_mm10_combined
# │   ├── GATC_hg38_mm10.bed
# │   ├── hg38_mm10.1.bt2l
# │   ├── hg38_mm10.2.bt2l
# │   ├── hg38_mm10.3.bt2l
# │   ├── hg38_mm10.4.bt2l
# │   ├── hg38_mm10.chrom.sizes
# │   ├── hg38_mm10.fa
# │   ├── hg38_mm10.fa.amb
# │   ├── hg38_mm10.fa.ann
# │   ├── hg38_mm10.fa.bwt
# │   ├── hg38_mm10.fa.pac
# │   ├── hg38_mm10.fa.sa
# │   ├── hg38_mm10.rev.1.bt2l
# │   ├── hg38_mm10.rev.2.bt2l
# │   ├── submit_bowtie2-build.sh
# │   └── submit_hicpro_digest.sh
# ├── mm10
# │   ├── GATC_mm10.bed
# │   ├── mm10.1.bt2
# │   ├── mm10.2.bt2
# │   ├── mm10.3.bt2
# │   ├── mm10.4.bt2
# │   ├── mm10.chrom.sizes
# │   ├── mm10.fa
# │   ├── mm10.rev.1.bt2
# │   └── mm10.rev.2.bt2

# Folder where refgenia assets are downloaded
DIR_REFGENIE=/home/mdozmorov/work/refgenie

# Folder where annotations are organized
DIR_ANNOTATIONS=/home/mdozmorov/work

# Create annotation folder structure
mkdir -p $DIR_ANNOTATIONS"/annotations"
mkdir -p $DIR_ANNOTATIONS"/annotations/hg38"
mkdir -p $DIR_ANNOTATIONS"/annotations/mm10"
mkdir -p $DIR_ANNOTATIONS"/annotations/hg38_mm10_combined"

# Link hg38 files
cd $DIR_ANNOTATIONS"/annotations/hg38"
ln -s $DIR_REFGENIE"/hg38_primary/fasta/default/hg38_primary.fa" hg38.fa   
ln -s $DIR_REFGENIE"/hg38_primary/fasta/default/hg38_primary.chrom.sizes" hg38.chrom.sizes
ln -s $DIR_REFGENIE"/hg38_primary/bowtie2_index/default/hg38_primary.1.bt2" hg38.1.bt2
ln -s $DIR_REFGENIE"/hg38_primary/bowtie2_index/default/hg38_primary.2.bt2" hg38.2.bt2
ln -s $DIR_REFGENIE"/hg38_primary/bowtie2_index/default/hg38_primary.3.bt2" hg38.3.bt2
ln -s $DIR_REFGENIE"/hg38_primary/bowtie2_index/default/hg38_primary.4.bt2" hg38.4.bt2
ln -s $DIR_REFGENIE"/hg38_primary/bowtie2_index/default/hg38_primary.rev.1.bt2" hg38.rev.1.bt2
ln -s $DIR_REFGENIE"/hg38_primary/bowtie2_index/default/hg38_primary.rev.2.bt2" hg38.rev.2.bt2
ln -s $DIR_REFGENIE"/hg38_primary/bwa_index/default/hg38_primary.fa.amb" hg38.fa.amb 
ln -s $DIR_REFGENIE"/hg38_primary/bwa_index/default/hg38_primary.fa.ann" hg38.fa.ann
ln -s $DIR_REFGENIE"/hg38_primary/bwa_index/default/hg38_primary.fa.bwt" hg38.fa.bwt
ln -s $DIR_REFGENIE"/hg38_primary/bwa_index/default/hg38_primary.fa.pac" hg38.fa.pac
ln -s $DIR_REFGENIE"/hg38_primary/bwa_index/default/hg38_primary.fa.sa" hg38.fa.sa
cd ../..

# Link hg38_mm10_combined files
cd $DIR_ANNOTATIONS"/annotations/hg38_mm10_combined"
ln -s $DIR_REFGENIE"/hg38_mm10/fasta/default/hg38_mm10.fa" hg38_mm10.fa   
ln -s $DIR_REFGENIE"/hg38_mm10/fasta/default/hg38_mm10.chrom.sizes" hg38_mm10.chrom.sizes
ln -s $DIR_REFGENIE"/hg38_mm10/bowtie2_index/default/hg38_mm10.1.bt2l" hg38_mm10.1.bt2l
ln -s $DIR_REFGENIE"/hg38_mm10/bowtie2_index/default/hg38_mm10.2.bt2l" hg38_mm10.2.bt2l
ln -s $DIR_REFGENIE"/hg38_mm10/bowtie2_index/default/hg38_mm10.3.bt2l" hg38_mm10.3.bt2l
ln -s $DIR_REFGENIE"/hg38_mm10/bowtie2_index/default/hg38_mm10.4.bt2l" hg38_mm10.4.bt2l
ln -s $DIR_REFGENIE"/hg38_mm10/bowtie2_index/default/hg38_mm10.rev.1.bt2l" hg38_mm10.rev.1.bt2l
ln -s $DIR_REFGENIE"/hg38_mm10/bowtie2_index/default/hg38_mm10.rev.2.bt2l" hg38_mm10.rev.2.bt2l
ln -s $DIR_REFGENIE"/hg38_mm10/bwa_index/default/hg38_mm10.fa.amb" hg38_mm10.fa.amb 
ln -s $DIR_REFGENIE"/hg38_mm10/bwa_index/default/hg38_mm10.fa.ann" hg38_mm10.fa.ann
ln -s $DIR_REFGENIE"/hg38_mm10/bwa_index/default/hg38_mm10.fa.bwt" hg38_mm10.fa.bwt
ln -s $DIR_REFGENIE"/hg38_mm10/bwa_index/default/hg38_mm10.fa.pac" hg38_mm10.fa.pac
ln -s $DIR_REFGENIE"/hg38_mm10/bwa_index/default/hg38_mm10.fa.sa" hg38_mm10.fa.sa
cd ../..

# Link mm10 files
cd $DIR_ANNOTATIONS"/annotations/mm10"
ln -s $DIR_REFGENIE"/mm10_primary/fasta/default/mm10_primary.fa" mm10.fa   
ln -s $DIR_REFGENIE"/mm10_primary/fasta/default/mm10_primary.chrom.sizes" mm10.chrom.sizes
ln -s $DIR_REFGENIE"/mm10_primary/bowtie2_index/default/mm10_primary.1.bt2" mm10.1.bt2
ln -s $DIR_REFGENIE"/mm10_primary/bowtie2_index/default/mm10_primary.2.bt2" mm10.2.bt2
ln -s $DIR_REFGENIE"/mm10_primary/bowtie2_index/default/mm10_primary.3.bt2" mm10.3.bt2
ln -s $DIR_REFGENIE"/mm10_primary/bowtie2_index/default/mm10_primary.4.bt2" mm10.4.bt2
ln -s $DIR_REFGENIE"/mm10_primary/bowtie2_index/default/mm10_primary.rev.1.bt2" mm10.rev.1.bt2
ln -s $DIR_REFGENIE"/mm10_primary/bowtie2_index/default/mm10_primary.rev.2.bt2" mm10.rev.2.bt2
ln -s $DIR_REFGENIE"/mm10_primary/bwa_index/default/mm10_primary.fa.amb" mm10.fa.amb 
ln -s $DIR_REFGENIE"/mm10_primary/bwa_index/default/mm10_primary.fa.ann" mm10.fa.ann
ln -s $DIR_REFGENIE"/mm10_primary/bwa_index/default/mm10_primary.fa.bwt" mm10.fa.bwt
ln -s $DIR_REFGENIE"/mm10_primary/bwa_index/default/mm10_primary.fa.pac" mm10.fa.pac
ln -s $DIR_REFGENIE"/mm10_primary/bwa_index/default/mm10_primary.fa.sa" mm10.fa.sa
cd ../..



