#!/bin/bash -l
#$ -pe smp 2 -R y -binding linear:2
#$ -l h_rt=1:00:00
#$ -l s_rt=1:00:00
#$ -l h_vmem=8G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2
use Python-3.9

python /medpop/esp2/mkaminen/pops/pops.py \
	--gene_annot_path /medpop/esp2/mkaminen/pops/data/gene_annot_jun10.txt \
	--feature_mat_prefix /medpop/esp2/mkaminen/pops/data/features_munged/pops_features \
	--num_feature_chunks 1 \
	--magma_prefix /medpop/esp2/mkaminen/pops/data/magma_scores/r_sphericity \
	--control_features_path /medpop/esp2/mkaminen/pops/data/features_jul17_control.txt \
	--out_prefix /medpop/esp2/mkaminen/pops/out/r_sphericity \
	--verbose

