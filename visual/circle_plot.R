#!/bin/bash -l
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 4 -R y -binding linear:4
#$ -l h_vmem=2G
#$ -j y

#install.packages("CMplot")
#library(CMplot)
source("https://raw.githubusercontent.com/YinLiLin/CMplot/master/R/CMplot.r")

library(ggplot2)
library(dplyr)
library(tidyr)
library(qqman)
library(data.table)
library(stringr)

# first merge together all files
wdir='/broad/hptmp/mkaminen/spleen/regenie/spleen'
wdir2='/broad/hptmp/mkaminen/spleen/regenie/small_spleen'
outfile = paste0(wdir,'/circle_plot.jpg')

#phenotypes=list('sphericity', 'graynonuniform', 'kurtosis', 'graydependence', 'grayemphasis', 'grayinversediff')

#overall_df = NULL
#for (i in 1:length(phenotypes)) {
#	df = read.table(paste(wdir, "/filt_spleen_chr_", phenotypes[[i]], ".regenie", sep= ""), header =TRUE)
#	df = df[, c("ID", "CHROM", "GENPOS", "Pvalue")]
#	colnames(df)[colnames(df) == "Pvalue"] = phenotypes[[i]]
#	colnames(df)[colnames(df) == "ID"] = "SNP"
#       colnames(df)[colnames(df) == "CHROM"] = "Chromosome"
#	colnames(df)[colnames(df) == "GENPOS"] = "Position"

#	if (i==1){
#		overall_df = df	
#	} else {
#		overall_df = merge(overall_df, df, by = c("SNP", "Chromosome", "Position"))
#	}
#	print(head(overall_df, 5))
#	print(nrow(overall_df))
#	print(ncol(overall_df))
#}

#print(head(overall_df,10))
#print(nrow(overall_df))
#print(ncol(overall_df))

#write.table(overall_df,paste0(wdir,"/all_pheno_pvals.txt"), sep="\t", quote=FALSE)
df <- read.table(paste0(wdir,"/all_pheno_pvals.txt"), sep="\t")
ids <- c("rs11066320")
#CMplot(df,type="p",plot.type="c",chr.labels=paste("Chr",c(1:22),sep=""),r=0.4,outward=FALSE,cir.chr.h=1.3,chr.den.col="black",threshold=5*10^-8, file="jpg",dpi=300,file.output=TRUE,verbose=TRUE,width=10,height=10,amplify=T,signal.col="red",signal.cex=1.25,trait.legend.ncol = 6, highlight = ids, highlight.text = ids, trait.legend.pos="right", trait.legend.cex=2, file.name="splenic_only")

# add in cad_gwas
cad <- read.table(paste0(wdir2, "/cad_gwas_rsid.tsv"), sep="\t", header=TRUE)
cad <- cad[, c("ID", "p_value", "chromosome", "base_pair_location")]
colnames(cad)[colnames(cad) == "ID"] = "SNP"
colnames(cad)[colnames(cad) == "p_value"] = "CAD"
colnames(cad)[colnames(cad) == "chromosome"] = "Chromosome"
colnames(cad)[colnames(cad) == "base_pair_location"] = "Position"

print(colnames(df))
print(colnames(cad))
df_cad <- merge(df, cad, by = c("SNP", "Chromosome", "Position"))
print(colnames(df_cad))
CMplot(df_cad,type="p",plot.type="c",col=c("#ADD8E6"), chr.labels=paste("Chr",c(1:22),sep=""),ylab = c("Spher", "GrayNonUnif", "Kurt", "GrayDep", "GrayEmph", "GrayID"), threshold=5*10^-8, r=0.4,outward=TRUE,cir.chr.h=1.3,chr.den.col="black",file="jpg",dpi=300,file.output=TRUE,verbose=TRUE,width=10,height=10,amplify=T,trait.legend.ncol = 7, signal.col="red", signal.cex=1, trait.legend.pos="right", trait.legend.cex=2, file.name="splenic_cad_2color_lab")

