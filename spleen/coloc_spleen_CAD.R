#install.packages("coloc")
library(coloc)
spleen_gwas_path = "/broad/hptmp/mkaminen/spleen/regenie/small_spleen/filt_small_spleen_chr_sphericity.regenie"
cad_gwas_path = "/broad/hptmp/mkaminen/spleen/regenie/small_spleen/cad_gwas.tsv"
out_path = "/broad/hptmp/mkaminen/spleen/regenie/small_spleen/cad_spleen_inter_SNPs.txt"


spleen <- read.csv(spleen_gwas_path, sep = "\t")
cad <- read.csv(cad_gwas_path, sep = "\t")

colnames(spleen)[colnames(spleen) == "A1FREQ"] ="MAF"
colnames(spleen)[colnames(spleen) == "ID"] ="snp"

colnames(cad)[colnames(cad) == "markername"] ="snp"
colnames(cad)[colnames(cad) == "effect_allele_frequency"] ="MAF"

print(colnames(spleen))
print(colnames(cad))
my.res <- coloc.abf(dataset1=list(MAF=spleen$MAF, pvalues=spleen$Pvalue, N=nrow(spleen),type="quant"),dataset2=list(MAF=cad$MAF, pvalues=cad$p_value, N=nrow(cad)))

