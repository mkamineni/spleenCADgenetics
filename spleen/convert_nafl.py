import pandas as pd
import numpy as np

#df = pd.read_csv("/broad/hptmp/mkaminen/spleen/regenie/small_spleen/nafl_gwas.txt", sep = "\t")
#df["Effect"] = np.log(df["Effect"])
#df["Info"] = df["Info"].astype(float)
#print(df.Info.value_counts())
#df = df[df.Info > 0.9]
#df = df.drop('Info', axis =1)
#df = df.rename(columns = {"rsName":"SNP"})
#df.to_csv("/broad/hptmp/mkaminen/spleen/regenie/small_spleen/nafl_gwas_final.tsv", sep = "\t", index = False)

df = pd.read_csv("/broad/hptmp/mkaminen/spleen/regenie/small_spleen/whr_gwas.txt", delim_whitespace=True)
print(df.columns)
print(df.head())
df = df.dropna()
df = df[df.SNP.str.contains(":")]
df["SNP"] = df["SNP"].str.split(":").str[0]
print(df.SNP.value_counts())
df.to_csv("/broad/hptmp/mkaminen/spleen/regenie/small_spleen/whr_gwas_final.tsv", sep = "\t", index = False)
