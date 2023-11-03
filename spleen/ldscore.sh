#!/bin/bash -l
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 2 -R y -binding linear:2
#$ -l h_vmem=100G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2
use Python-2.7
use Anaconda
#cd /medpop/esp2/mkaminen/spleen/ldsc
#conda env create --file environment.yml
source activate ldsc
cd /medpop/esp2/mkaminen/spleen/ldsc

python ldsc.py \
        --bfile /broad/hptmp/mkaminen/spleen/regenie/small_spleen/ukb_cal \
	--l2 \
	--ld-wind-cm 1 \
	--out ld2

