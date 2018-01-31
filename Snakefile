import re
import csv

from snakemake.utils import update_config

from functions import *

default_config = {
    'output_dir': '/home/chunyu/refseq_downloaded/cdiff_20170928',
    'group': 'bacteria',
    'kraken_db': '/home/chunyu/refseq_downloaded/toRespublica_20170330/bacteriaGenomes/fungi'
}

update_config(default_config, config)
config = default_config


include: "download_genome.rules"
include: "kraken_fasta.rules"

rule all:
    input:
        expand(
            config['output_dir'] + '/' + "{group}/{taxid}/{taxid}.kraken.masked.fna",
            group=config['group'],
            taxid=generate_list(config['output_dir'] + '/' + config['group'] + '/genome_urls.txt'))
