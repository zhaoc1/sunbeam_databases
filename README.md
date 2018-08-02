# sunbeam_databases

This is the place where we download/build the necessary databases required for [sunbeam](https://github.com/sunbeam-labs/sunbeam). 

- download refseq genomes for a group using Snakemake
- build standard kraken database
- mask low-complexity regions from the refseq seuqneces and reformat for krakenDB format
- build krakenHLL database of interests
- add custome sequences to krakenDB
- bsh and bai-operon gene/protein sequences
- butyrate producing gene/sequences

## Install
```sh
conda install -c bioconda snakemake
# OR simplyly activate the sunbeam environment
source activate sunbeam
git clone https://github.com/zhaoc1/sunbeam_databases
cd sunbeam_databases
```

## Download refseq genomes 

This can be used with any group listed under the genomes/refseq directory, but recommended groups would be:

- barcteria
- fungi
- archaea
- protozoa

### Example

To download the nucleotide sequences of all Refseq fungal sequences (update your config file with group: fungi):

```bash
# First, downloads the `assembly_summary.txt` from NCBI ftp, and the list of all genomes
# You can also `grep` the species of interest from the generated `genome_urls.txt`
snakemake download_group_nucl

# Second, download the sequences
snakemake download_group_nucl
```

The output genomes are listed under `{group}/{accession}.fna.gz` or `{group}/{accession}.faa.gz`.

## Build Kraken database

```bash
# Thrid, add seqeucnes to existing kraken db
snakemake add_group_to_kraken_db
```

## Custom databases of interest

### bile salt hydrolase

The bsh genes were selected from the [PMID: 18757757](https://www.ncbi.nlm.nih.gov/pubmed/18757757). The protein sequences were downloaded from NCBI and saved in `dbs/bsh_20180214.txt` and `dbs/bsh_20180214.fasta`.

### bai operon

I selected the complete bai operon genes from 3 species: Clostridium hiranonis, Clostridium scindens and Clostridium hylemonae. The protein sequences were downloaded from the [PubSEED database](http://pubseed.theseed.org/). Refer to [PMID: 16299351](https://www.ncbi.nlm.nih.gov/pubmed/16299351) and [preprint](https://www.biorxiv.org/content/early/2017/12/04/229138).

