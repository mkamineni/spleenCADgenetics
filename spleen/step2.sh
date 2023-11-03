#!/bin/bash -l
#$ -wd /medpop/esp2/mkaminen/logjobs
#$ -l h_rt=96:00:00
#$ -l s_rt=96:00:00
#$ -pe smp 2 -R y -binding linear:4
#$ -l h_vmem=4G
#$ -j y
#$ -t 1-22

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2

trait=spleen
wdir=/broad/hptmp/mkaminen/spleen/regenie/${trait}
phenofile=/medpop/esp2/mkaminen/data/${trait}_UKB.txt
covarfile=/medpop/esp2/mkaminen/data/${trait}_UKB.txt
covarCol=sex,age,PC{1:10}
catcovar=genotyping_array
phenoCol=grayemphasis

mkdir -p ${wdir}
cd ${wdir}

chr=${SGE_TASK_ID}

/medpop/esp2/mkaminen/data/regenie_v3.2.8.gz_x86_64_Centos7_mkl \
  --step 2 \
  --bgen /broad/ukbb/imputed_v3/ukb_imp_chr${chr}_v3.bgen \
  --phenoFile ${phenofile} \
  --phenoCol ${phenoCol} \
  --covarFile ${covarfile} \
  --covarColList ${covarCol} \
  --catCovarList ${catcovar} \
  --sample /medpop/esp2/pradeep/UKBiobank/v3data/ukb7089_imp_chr15_v3_s487395.sample \
  --bsize 200 \
  --approx \
  --pThresh 0.01 \
  --maxstep-null 2 \
  --pred /medpop/esp2/mkaminen/logjobs/${trait}2_pred.list \
  --out ${trait}2_chr${chr}
