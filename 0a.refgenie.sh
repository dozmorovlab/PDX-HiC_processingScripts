# Install refgenie, http://refgenie.databio.org/en/latest/
# http://refgenie.databio.org/en/latest/install/
python -m pip install refgenie

# path/to is the path to the directory where all genome assets will be downloaded
export REFGENIE=/path/to/refgenie.yaml
refgenie init -c $REFGENIE

# Use these `pull` commands to download the necessary indexes:
refgenie pull hg38_primary/fasta
refgenie pull mm10_primary/fasta
refgenie pull hg38_mm10/fasta
refgenie pull hg38_primary/bowtie2_index
refgenie pull mm10_primary/bowtie2_index
refgenie pull hg38_mm10/bowtie2_index
refgenie pull hg38_primary/bwa_index
refgenie pull mm10_primary/bwa_index
refgenie pull hg38_mm10/bwa_index

# Once pulled, these assets can be located with, e.g.:
# refgenie seek hg38_primary/bowtie2_index