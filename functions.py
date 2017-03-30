import re
import csv
from pathlib import Path

def convert_to_genome_path(ftp_path):
    path = re.match(
        r'(ftp://ftp.ncbi.nlm.nih.gov/genomes/all/.*/)(GCF_.+)', ftp_path)
    if path:
        ftp, name = path.groups()
        return "{ftp}{name}/{name}_genomic.fna.gz".format(
            ftp=ftp, name=name)

def generate_list(genome_urls_fp):
    if not Path(genome_urls_fp).exists():
        return []
    urls = csv.DictReader(open(genome_urls_fp), fieldnames=['taxid','url'], delimiter='\t')
    return [r['taxid'] for r in urls]


