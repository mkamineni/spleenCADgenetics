#! /bin/bash
#$ -cwd
#$ -R y
#$ -l h_vmem=10g

source /broad/software/scripts/useuse
use UGER
use Tabix
reuse GCC-5.2

/medpop/esp2/mkaminen/Tools/magma \
  --bfile /broad/hptmp/mkaminen/spleen/regenie/spleen/ukb_cal \
  --gene-annot /medpop/esp2/projects/software/PoPS/data/magma_0kb.genes.annot \
  --pval /medpop/esp2/mkaminen/pops/data/kurtosisgwas_for_magma.txt use=ID,Pvalue ncol=N \
  --gene-model snp-wise=mean \
  --out /medpop/esp2/mkaminen/pops/data/magma_scores/r_kurtosis







