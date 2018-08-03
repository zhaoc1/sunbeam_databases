#!/usr/bin/env bash

set -e

# Chunyu Zhao

# name your database with time stamp
KRAKEN_DB_NAME=/mnt/isilon/microbiome/analysis/biodata/krakendb/standard_20180803

# download data
kraken-build --db $KRAKEN_DB_NAME --download-taxonomy
kraken-build --db $KRAKEN_DB_NAME --download-library bacteria
kraken-build --db $KRAKEN_DB_NAME --download-library viral
kraken-build --db $KRAKEN_DB_NAME --download-library plasmid
kraken-build --db $KRAKEN_DB_NAME --download-library human
kraken-build --db $KRAKEN_DB_NAME --download-library archaea


# mask of low-complexity sequences with dustmasker and 
# convert low complexity regions to N'x with set (skip headers)
# kraken2 has the option to `mask` by default

for i in `find $KRAKEN_DB_NAME \( -name '*.fna' -o -name '*.ffn' \)`
  do
    dustmasker -in $i -infmt fasta -outfmt fasta | sed -e '/>/!s/a\|c\|g\|t/N/g' > tempfile
    mv tempfile $i
  done

# add_g

# build the database
#kraken-build --build --db $KRAKEN_DB_NAME --threads 32 --jellyfish-hash-size 6400M
#kraken-build --clean --db $KRAKEN_DB_NAME # better to keep the library
