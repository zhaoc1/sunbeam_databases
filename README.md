# sunbeam_databases

This is the place where we download/build all the necessary databases required for [sunbeam](https://github.com/sunbeam-labs/sunbeam).

Download refseq genomes for a group using Snakemake
Preprocess refseq sequences for kraken db format

## install
```sh
conda install -c bioconda snakemake
git clone https://github.com/zhaoc1/refseq_kraken
cd refseq_kraken
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
