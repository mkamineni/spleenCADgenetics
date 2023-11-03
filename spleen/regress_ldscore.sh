#!/bin/bash -l
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 4 -R y -binding linear:4
#$ -l h_vmem=8G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use Python-2.7
use Anaconda
source activate ldsc
cd /medpop/esp2/mkaminen/spleen

# LD Score Regression
python ldsc/ldsc.py \
  --h2 data/grayinversediff.sumstats.gz \
  --ref-ld data/UKBB.ALL.ldscore/UKBB.EUR.rsid \
  --w-ld data/UKBB.ALL.ldscore/UKBB.EUR.rsid \
  --out grayinversediff

