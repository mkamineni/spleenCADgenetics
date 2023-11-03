library("tidyverse")
library("data.table")

trait <- "small_spleen"
#df <- read.csv('../data/gwas_pheno_small_spleen.csv')
df <- read.csv(paste('../data/gwas_pheno_', trait, '.csv', sep=""))

drops <- c("FID")
df <- df[ , !(names(df) %in% drops)]

#covar_df <- read.table('/medpop/esp2/btruong/Projects/general/data/UKB_basic_covariates.txt', header = TRUE)
covar_df <- read.table('/medpop/esp2/btruong/Projects/sharing/UKB_covariates.txt', header = TRUE)
print(nrow(df))
print(nrow(covar_df))
print(colnames(df))
print(colnames(covar_df))
new_df <- merge(df, covar_df, by = c('IID'))
print(nrow(new_df))
#new_df <- new_df %>% 
#  relocate('FID')
new_df <- new_df[ , c('FID', 'IID', colnames(new_df)[!(colnames(new_df) %in% c('FID', 'IID', 'X'))])]
head(new_df, 10)
new_df$sex <- as.factor (new_df$sex) 
new_df$sex<- as.numeric (new_df$sex)%%2 # female is 1, male is 0
new_df$age_sex <- new_df$sex*new_df$age
new_df$age_age <- new_df$age*new_df$age
head(new_df, 10)
print(colnames(new_df))


#euro_df <- read.table("/medpop/esp2/btruong/Projects/snp_risk_interaction/data/ukb_sqc_v2_7089.tsv", sep = "\t", header=TRUE)
#euro_df <- fread("/medpop/esp2/btruong/Projects/snp_risk_interaction/data/ukb_sqc_v2_7089.tsv", select = c("eid", "in_white_British_ancestry"))
#print(nrow(euro_df))
#euro_df <- euro_df[euro_df$in_white_British_ancestry==1, ]
#print(nrow(euro_df))
#colnames(euro_df)[colnames(euro_df) == "eid"] <- "FID"
#euro_df <- euro_df[, c("FID")]
#new_df <- merge(new_df, euro_df, by = c("FID"))

write.table(new_df, paste("../data/", trait, "_UKB_more_covar.txt", sep=""), quote = FALSE, row.names = FALSE)

