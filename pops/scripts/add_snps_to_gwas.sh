#! /bin/bash
#$ -R y
#$ -l h_vmem=10g

source /broad/software/scripts/useuse
use R-4.0
Rscript /medpop/esp2/mkaminen/pops/scripts/add_snps_to_gwas.R
