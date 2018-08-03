#/bin/bash
set -e

# 20180802: before combat
# I don't really know if the standard database make the low-complexity region
# I think I will just build in first and see. before I do the whole thing manually.


KRAKEN_DB_NAME="/home/chunyu/krakendb/bacteria"

# download data
kraken-build --db $KRAKEN_DB_NAME --download-taxonomy
kraken-build --db $KRAKEN_DB_NAME --download-library bacteria
#kraken-build --db $KRAKEN_DB_NAME --download-library viruses


# filter with Dustmasker and convert low complexity regions to N's with Sed (skipping headers)
for i in `find $KRAKEN_DB_NAME \( -name '*.fna' -o -name '*.ffn' \)`
  do
    dustmasker -in $i -infmt fasta -outfmt fasta | sed -e '/>/!s/a\|c\|g\|t/N/g' > tempfile
    mv tempfile $i
  done

# add_group_to_kraken_db if needed

# build the database
kraken-build --build --db $KRAKEN_DB_NAME --threads 16 --jellyfish-hash-size 6400M
#kraken-build --clean --db $KRAKEN_DB_NAME # better to keep the library
