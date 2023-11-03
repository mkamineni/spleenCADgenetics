#!/bin/bash -l
#$ -wd /medpop/esp2/mkaminen/logjobs
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 4 -R y -binding linear:4
#$ -l h_vmem=8G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2

trait=spleen


wdir=/broad/hptmp/mkaminen/spleen/regenie/${trait}
phenofile=/medpop/esp2/mkaminen/data/${trait}_UKB.txt
covarfile=/medpop/esp2/mkaminen/data/${trait}_UKB.txt
covarCol=sex,age,PC{1:10}
catcovar=genotyping_array
snplist=/broad/hptmp/mkaminen/spleen/regenie/${trait}/qc_pass_mac.snplist
samplist=/broad/hptmp/mkaminen/spleen/regenie/${trait}/qc_pass_mac.id
out=${trait}2
bed=/broad/hptmp/mkaminen/spleen/regenie/${trait}/ukb_cal

/medpop/esp2/mkaminen/data/regenie_v3.2.8.gz_x86_64_Centos7_mkl \
--step 1 \
--out ${out} \
--bed ${bed} \
--phenoFile ${phenofile} \
--phenoColList grayemphasis \
--covarFile ${covarfile} \
--bsize 1000 \
--lowmem \
--extract ${snplist} \
--keep ${samplist} \
--covarColList ${covarCol} \
--catCovarList ${catcovar} \
  
  
 
