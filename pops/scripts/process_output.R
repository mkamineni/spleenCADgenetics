library(data.table)
library(dplyr)

df <- read.table("../out/r_sphericity.preds", sep = "\t", header=TRUE)
print(head(df, 5))

gene_annot<-read.table("../data/gene_annot_jun10.txt", sep = "\t", header=TRUE)

final <- merge(df, gene_annot, by=c("ENSGID"))
final <- final[order(final$PoPS_Score, decreasing = TRUE), ]

final <- final%>%select(ENSGID, NAME, PoPS_Score)
write.table(final, "../out/sorted_r_sphericity.preds", quote = FALSE, row.names=FALSE)

