#!/bin/bash
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
phenofile=/medpop/esp2/mkaminen/spleen/data/${trait}_UKB.txt
covarfile=/medpop/esp2/mkaminen/spleen/data/${trait}_UKB.txt
covarCol=age,PC{1:10}
catcovar=batch,array
#snplist=/broad/hptmp/mkaminen/spleen/regenie/plink_ukb/qc_pass.snplist
#samplist=/broad/hptmp/mkaminen/spleen/regenie/plink_ukb/qc_pass.id
out=${trait}
#bed=/broad/hptmp/mkaminen/spleen/regenie/plink_ukb/ukb_cal

mkdir -p ${wdir}
cd ${wdir}
#ls ${wdir}
###############################
# creating symbolic links between data paths and shorter names, and then writing the shorter names into a merged list
# bed files contain genotype data
# bim files contain SNP names and their locations in chromosomes
# fam files contain information about the individuals
# want to go through all the chromosomes and create these symbolic links

mkdir -p ${wdir}
cd ${wdir}
###############################
#rm ${wdir}/mergelist.txt
#for chr in {1..22}; do 
#  ln -s /broad/ukbb/genotype/ukb_cal_chr${chr}_v2.bed ukb_chr${chr}_v2.bed
#  ln -s /broad/ukbb/genotype/ukb_snp_chr${chr}_v2.bim ukb_chr${chr}_v2.bim
#  ln -s /medpop/esp2/pradeep/UKBiobank/v2data/ukb708_cal_chr1_v2_s488374.fam ukb_chr${chr}_v2.fam
#  echo "ukb_chr${chr}_v2" >> mergelist.txt
#done

#reuse PLINK
#plink --bfile ukb_chr1_v2 --merge-list mergelist.txt --make-bed --memory 32000 --out ukb_cal2

reuse PLINK2
/medpop/esp2/btruong/Tools/plink2 \
	--bfile ukb_cal \
	--maf 0.01 --mac 20 --geno 0.1 --hwe 1e-15 \
	--memory 4000 \
	--mind 0.1 \
	--write-snplist --write-samples --no-id-header \
	--out qc_pass_mac
