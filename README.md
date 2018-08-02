# sunbeam_databases

This is the place where we download/build the necessary databases required for [sunbeam](https://github.com/sunbeam-labs/sunbeam). 

- download refseq genomes for a group using Snakemake
- build standard kraken database
- mask low-complexity regions from the refseq seuqneces and reformat for krakenDB format
- build krakenHLL database of interests
- add custome sequences to krakenDB
- BSH and bai-operon gene/protein sequences
- butyrate producing gene/sequences

## Install
```sh
conda install -c bioconda snakemake
# OR simplyly activate the sunbeam environment
source activate sunbeam
git clone https://github.com/zhaoc1/sunbeam_databases
cd sunbeam_databases
```

## usage
This can be used with any group listed under the genomes/refseq directory, but recommended groups would be:

- barcteria
- fungi
- archaea
- protozoa

### example
To download all the fungal refseq genomes:
```sh
# First, downloads the list of all the genomes
snakemake --config group=fungi download_group

# Next, actually download the genomes (named by their taxid)
snakemake --config group=fungi download_group

# Thrid, add seqeucnes to existing kraken db
snakemake --config group=fungi add_group_to_kraken_db
```

## output
The genomes are listed under `{group}/{taxid}/{taxid}.fna.gz`.
