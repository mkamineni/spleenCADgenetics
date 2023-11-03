#!/bin/bash -l
#$ -pe smp 2 -R y -binding linear:2
#$ -l h_rt=1:00:00
#$ -l s_rt=1:00:00
#$ -l h_vmem=8G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2
use Python-3.6

python /medpop/esp2/mkaminen/pops/munge_feature_directory.py \
	--gene_annot_path /medpop/esp2/mkaminen/pops/data/gene_annot_jun10.txt \
	--feature_dir /medpop/esp2/mkaminen/pops/data/features_raw \
	--save_prefix /medpop/esp2/mkaminen/pops/data/features_munged/pops_features \
