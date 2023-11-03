#!/bin/bash -l
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 4 -R y -binding linear:4
#$ -l h_vmem=2G
#$ -j y

library(ggplot2)
library(dplyr)
library(tidyr)
library(qqman)
library(data.table)
library(stringr)

# first merge together all files
wdir='/broad/hptmp/mkaminen/spleen/regenie/spleen'
phenotype='kurtosis'
dfs = list() 
concat = TRUE
if (concat==TRUE){
	print(phenotype)
	for (val in 1:22){
		df = read.table(paste(wdir, "/spleen_chr", as.integer(val), "_", phenotype, ".regenie", sep= ""), header =TRUE)
		df$LOG10P = as.numeric(df$LOG10P)
		df$Pvalue = 10**-(df$LOG10P)
		df$CHROM = as.numeric(df$CHROM)
		#write.table(df, paste(wdir, "/edit_small_spleen_chr", as.integer(val), "_", phenotype, ".regenie", sep= ""))
		#df = df[,c("CHROM","GENPOS", "A1FREQ", "ID", "Pvalue")]	
		dfs[[val]] = data.frame(df)
		#dfs = append(dfs, data.frame(df))
		print(nrow(df))
	}
	
	print(length(dfs))
	df <- bind_rows(dfs)
	print(nrow(df))
	#df = df_orig %>% filter(CHROM <= 22 & ((A1FREQ >= 0.05 & get("Pvalue")<5e-2) | (A1FREQ < 0.05 & get("Pvalue")<5e-8)))
        print(nrow(df))
	filt_df = df %>% filter((A1FREQ > 0.01 & A1FREQ <= 0.99))
	print(nrow(df))
	#pdf(paste(wdir, "/", phenotype, "_manhatttan.png", sep=""))
	print("lambda all data")
	set.seed(1121)
	chisq1 <- qchisq(1-df$Pvalue,1)
	lambda1 <- median(chisq1)/qchisq(0.5,1)
	print(lambda1)

	print("lambda common variants")
        chisq1 <- qchisq(1-filt_df$Pvalue,1)
	lambda1 <- median(chisq1)/qchisq(0.5,1)
	print(lambda1)

	png(paste(wdir, "/", phenotype, "2_manhattan_filter.png", sep=""), width=1500, height=1500)
	#manhattan(filt_df, chr="CHROM", bp="GENPOS", snp="ID", p="Pvalue", main="Gray Inverse Diff")
        manhattan(filt_df, chr="CHROM", bp="GENPOS", snp="ID", p="Pvalue", col = c("mediumseagreen", "grey74"), cex = 0.6, cex.axis = 2.0)
	dev.off()

	#png(paste(wdir, "/", phenotype, "2_filter_qq.png", sep=""), width=1500, height=1500)
	#qq(filt_df$Pvalue)
	#dev.off()

        #setorder(df, cols = "Pvalue")
        #write.table(df, paste(wdir, "/spleen2_chr_", phenotype, ".regenie", sep= ""), sep="\t", quote=FALSE)

	#setorder(filt_df, cols = "Pvalue")
	#write.table(filt_df, paste(wdir, "/filt_spleen2_chr_", phenotype, ".regenie", sep= ""), sep="\t", quote=FALSE)
} else {
	df = read.table(paste(wdir, "/ordered_small_spleen_chr_", phenotype, ".regenie", sep= ""), header=TRUE)
	print(nrow(df))
        #df = df[,c("CHROM", "GENPOS", "ID", "Pvalue", "A1FREQ")]
	df = df[which(complete.cases(df)),]
        print(nrow(df))
	#df = df %>% filter((A1FREQ > 0.01 & A1FREQ <= 0.99))
	print(nrow(df))
	#pdf(paste(wdir, "/", phenotype, "_manhatttan.png", sep=""))
	png(paste(wdir, "/", phenotype, "_manhattan.png", sep=""), width=1500, height=1500)
	manhattan(df, chr="CHROM", bp="GENPOS", snp="ID", p="Pvalue", annotatePval = 0.01, main="Spleen Sphericity")
	dev.off()
	stop()

	df = df %>% 
    		mutate(QuantPval = cut(df$A1FREQ, quantile(df$Pvalue), include.lowest=TRUE, labels=FALSE))
	print(colnames(df))
	print(head(df,10))
	for (i in 1:4){
		png(paste(wdir, "/", phenotype, as.integer(i), "_qq.png", sep=""), width=1500, height=1500)
		qq(df[df$QuantPval == i, ]$Pvalue)
		print(i)
		dev.off()
	}
	
	# compute genomic inflation factor
	set.seed(1121)
	chisq1 <- qchisq(1-df$Pvalue,1)
	lambda1 <- median(chisq1)/qchisq(0.5,1)
	print(lambda1)
}
