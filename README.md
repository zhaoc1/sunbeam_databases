# sunbeam_databases

This is the place where we download/build/collect the necessary databases required for [sunbeam](https://github.com/sunbeam-labs/sunbeam). 

TODO:
- [eupathdb-clean](https://ccb.jhu.edu/data/eupathDB/)

## Install environment
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

## Download BLAST databases 

The downloaded nt database will be used for BLASTn assembled [contigs](https://github.com/sunbeam-labs/sunbeam/blob/dev/rules/annotation/blast.rules). 

  ```bash
  mkdir nt_20180816
  update_blastdb.pl --passive --decompress nt
  ```

## Build [Kraken 1]((http://ccb.jhu.edu/software/kraken/)) database

The bash script includes the following steps:
- mask low-complexity regions from the refseq sequences
- reformat maked sequences for krakenDB format
- add custom sequences to krakenDB

- [kraken2](https://ccb.jhu.edu/software/kraken/MANUAL.html#installation) paper is under preparation. And to keep it consistent with krakenhll, we decided to move on with kraken1. 

```bash
bash build_krakendb.sh
```

## Gene clusters of interest

We do the functional prediction from shotgun metagenomics data based on sequence homology, on both the reads and contigs level.

- [sbx_gene_clusters](https://github.com/sunbeam-labs/sbx_gene_clusters)
- [sbx_contigs](https://github.com/sunbeam-labs/sbx_contigs)

### bile salt hydrolase

The bsh genes were selected from the [PMID: 18757757](https://www.ncbi.nlm.nih.gov/pubmed/18757757). The protein sequences were downloaded from NCBI and saved in `dbs/bsh_20180214.txt` and `dbs/bsh_20180214.fasta`.

### bai operon

I selected the complete bai operon genes from 3 species: Clostridium hiranonis, Clostridium scindens and Clostridium hylemonae. The protein sequences were downloaded from the [PubSEED database](http://pubseed.theseed.org/), and saved in `dbs/bai.operon_20180801.fasta` and `dbs/bai.operon_20180801.txt`. Refer to [PMID: 16299351](https://www.ncbi.nlm.nih.gov/pubmed/16299351) and [preprint](https://www.biorxiv.org/content/early/2017/12/04/229138) for more information.

### butyrate producing genes

Sequences were downloaded from [JGI IMG](https://img.jgi.doe.gov/), based on the list provided in [PMID: 24757212](https://www.ncbi.nlm.nih.gov/pubmed/?term=Revealing+the+Bacterial+Butyrate+Synthesis+Pathways+by+Analyzing+(Meta)genomic+Data), and saved in `dbs/butyrate_20180612.faa` and `dbs/butyrate_20180612.tsv`.

### fungal genomes 

- [sbx_fungi_mapping](https://github.com/sunbeam-labs/sbx_fungi_mapping)

We collected 10 fungal genomes of interest (`dbs/fungi_20180502.txt`), and names and length of the chrmosomes/contigs are in `dbs/genome_contig_20180502.txt`.


## Build [krakenHLL](https://github.com/fbreitwieser/krakenhll) databases

### viral-neighbors

KrakenHLL supports building databases on subsets of the NCBI nucleotide collection nr/nt, which is most prominently the standard database for BLASTn. On the command line, you can specify to extract all bacterial, viral, archaeal, protozoan, fungal and helminth sequences. The list of protozoan taxa is based on Kaiju's.

  ```bash
  DBNAME=viral-neighbors
  krakenhll-download -db $DBNAME taxonomy
  krakenhll-download viral-neighbors --db $DBNAME --dust --threads 16
  ```

### microbial-nt
  
  ```bash
  DBNAME=microbial-nt
  krakenhll-download -db $DBNAME taxonomy
  krakenhll-download --db DB --taxa "archaea,bacteria,viral,fungi,protozoa,helminth" \
                     --dust --exclude-environmental-taxa nt
  ```
  
## Build [taxonomizr]((https://github.com/sherrillmix/taxonomizr)) databases

Parse NCBI taxonomy and accessions to assign taxonomy.

  ```R
  devtools::install_github("sherrillmix/taxonomizr")

  library(taxonomizr)
 
  getNamesAndNodes()
  getAccession2taxid()
  getAccession2taxid(types='prot')
  
  # on microb120
  read.accession2taxid(list.files('.','accession2taxid.gz$'),'accessionTaxa_20180813.sql')
 ```

## Metaphlan2 database

- [sbx_metaphlan](https://github.com/sunbeam-labs/sbx_metaphlan)

Respublica doesn't have network access to Bitbucket, so I pre-downloaded the metaphlan_databases on microb191 (```metaphlan2.py --install ```) and scp it to `/mnt/isilon/microbiome/analysis/biodata/metaphlan_databases`.

  ```bash
  DIR=$CONDA_PREFIX/opt
  cp -r /mnt/isilon/microbiome/analysis/biodata/metaphlan_databases $DIR
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
