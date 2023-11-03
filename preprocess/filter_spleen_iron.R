library(data.table)

path <- "/medpop/esp2/bhukar/shared/for_meghana/ukb674757.tab"
df <- read.table(path, header=TRUE, sep="\t")
print(colnames(df))
df <- df[, c('f.eid','f.21083.2.0', 'f.21170.2.0')]

write.table(df, "/medpop/esp2/mkaminen/spleen/data/ukb674757_spleen.tab")



