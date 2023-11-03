#!/bin/bash
#$ -wd /medpop/esp2/mkaminen/logjobs
#$ -N plink_${trait}
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 4 -R y -binding linear:4
#$ -l h_vmem=8G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2
use PLINK

plink --bfile /medpop/esp2/projects/1000G/1000g_EUR/1000G.EUR --clump /broad/hptmp/mkaminen/spleen/regenie/small_spleen/cad_spleen_grayinversediff_inter_SNPs.txt --clump-snp-field ID --out plink_grayinversediff

