# sunbeam_databases

This is the place where we download/build/collect the necessary databases required for [sunbeam](https://github.com/sunbeam-labs/sunbeam). 

- download refseq genomes for a group using Snakemake
- mask low-complexity regions from the refseq sequences
- reformat maked sequences for krakenDB format
- add custom sequences to krakenDB
- build standard kraken database
- build krakenHLL database of interests
- ?metaphlan

Databases of gene families of interest:
- bsh and bai-operon gene/protein sequences
- butyrate producing gene/sequences
- 10 fungal genomes
- [eupathdb-clean](https://ccb.jhu.edu/data/eupathDB/)
- R package [taxonomizr](https://github.com/sherrillmix/taxonomizr) database

## Install
```bash
conda install -c bioconda snakemake
```

OR simplyly activate the [sunbeam](https://github.com/sunbeam-labs/sunbeam) environment
```bash
source activate sunbeam
```

Make a local copy of the repository
```bash
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

- [kraken2](https://ccb.jhu.edu/software/kraken/MANUAL.html#installation) paper is under preparation. And to keep it consistent with [krakenhll](https://github.com/fbreitwieser/krakenhll), we decided to move on with [kraken1](http://ccb.jhu.edu/software/kraken/). 

```bash
bash build_krakendb.sh
```

## Gene families databases of interest

- [sbx_gene_clusters](https://github.com/sunbeam-labs/sbx_gene_clusters)

### bile salt hydrolase

The bsh genes were selected from the [PMID: 18757757](https://www.ncbi.nlm.nih.gov/pubmed/18757757). The protein sequences were downloaded from NCBI and saved in `dbs/bsh_20180214.txt` and `dbs/bsh_20180214.fasta`.

### bai operon

I selected the complete bai operon genes from 3 species: Clostridium hiranonis, Clostridium scindens and Clostridium hylemonae. The protein sequences were downloaded from the [PubSEED database](http://pubseed.theseed.org/), and saved in `dbs/bai.operon_20180801.fasta` and `dbs/bai.operon_20180801.txt`. Refer to [PMID: 16299351](https://www.ncbi.nlm.nih.gov/pubmed/16299351) and [preprint](https://www.biorxiv.org/content/early/2017/12/04/229138) for more information.

### butyrate producing genes

Sequences were downloaded from [JGI IMG](https://img.jgi.doe.gov/), based on the list provided in [PMID: 24757212](https://www.ncbi.nlm.nih.gov/pubmed/?term=Revealing+the+Bacterial+Butyrate+Synthesis+Pathways+by+Analyzing+(Meta)genomic+Data), and saved in `dbs/butyrate_20180612.faa` and `dbs/butyrate_20180612.tsv`.

### fungal genomes 

- [sbx_fungi_mapping](https://github.com/sunbeam-labs/sbx_fungi_mapping)

We collected 10 fungal genomes of interest (`dbs/fungi_20180502.txt`), and names and length of the chrmosomes/contigs are in `dbs/genome_contig_20180502.txt`.

## Build krakenHLL databases

### 

  ```bash
  DBNAME=viral-neighbors
  krakenhll-download -db $DBNAME taxonomy
  krakenhll-download viral-neighbors --db $DBNAME --dust --threads 16
  ```
