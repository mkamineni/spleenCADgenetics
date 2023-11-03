library(data.table)
library(stringr)
library(tidyr)
library(dplyr)

chip =fread("/broad/hptmp/mkaminen/spleen/regenie/spleen/filt_small_spleen_chr_kurtosis.regenie")
head(chip, 10)

#id=id%>%select(POS = hg19.pos)
#chip=merge(chip, id, by="POS")
chip=chip%>%select(ID, Pvalue, N)

write.table(chip,file="/medpop/esp2/mkaminen/pops/data/kurtosisgwas_for_magma.txt",sep="\t",quote = FALSE,row.names = FALSE)









