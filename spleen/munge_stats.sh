#!/bin/bash -l
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 2 -R y -binding linear:2
#$ -l h_vmem=4G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use Python-2.7
use Anaconda
source activate ldsc
cd /medpop/esp2/mkaminen/spleen

python ldsc/munge_sumstats.py* \
    --sumstats /broad/hptmp/mkaminen/spleen/regenie/small_spleen/nafl_gwas_final.tsv \
    --out data/nafld \
    --merge-alleles data/w_hm3.snplist \
    --chunksize 500000 \
    --a1 Amin \
    --a2 Amaj \
    --N 5921 \
    --chunksize 500000 \
