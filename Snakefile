import re
import csv

from functions import *

configfile: 'config.yaml'

include: "download_genome.rules"
include: "kraken_fasta.rules"

rule all:
    input:
        expand(
            config['output_dir'] + '/' + "{group}/{taxid}/{taxid}.kraken.masked.fna",
            group=config['group'],
            taxid=generate_list(config['output_dir'] + '/' + config['group'] + '/genome_urls.txt'))
