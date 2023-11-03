import pandas as pd

pval_cad = 5E-8
pval_spleen = 5E-8

spleen_gwas_path = "/broad/hptmp/mkaminen/spleen/regenie/spleen/filt_small_spleen_chr_grayinversediff.regenie"
cad_gwas_path = "/broad/hptmp/mkaminen/spleen/regenie/small_spleen/cad_gwas.tsv"
out_path = "/broad/hptmp/mkaminen/spleen/regenie/small_spleen/cad_spleen_grayinversediff_inter_SNPs.txt"
spleen_gwas = pd.read_csv(spleen_gwas_path, sep = "\t")
cad_gwas = pd.read_csv(cad_gwas_path, sep = "\t")

print(spleen_gwas.shape)
#print(spleen_gwas.Pvalue.min()<pval_spleen)
spleen_gwas["markername"]=spleen_gwas["CHROM"].astype(str)+":"+spleen_gwas["GENPOS"].astype(str)+"_"+spleen_gwas["ALLELE1"].astype(str)+"_"+spleen_gwas["ALLELE0"].astype(str)

print(spleen_gwas.markername.value_counts())
spleen_gwas_sig = spleen_gwas[spleen_gwas["Pvalue"]<pval_spleen][["markername", "Pvalue", "ID"]]
cad_gwas_sig = cad_gwas[cad_gwas["p_value"]<pval_cad][["markername", "p_value"]]

spleen_gwas = spleen_gwas[["markername", "ID"]]
merged_outer = pd.merge(spleen_gwas, cad_gwas, on="markername", how="right")
print(merged_outer.shape)
merged_outer = merged_outer.drop(["markername", "n"], axis=1)
#merged_outer['n'] = merged_outer['n'].astype(int)
merged_outer.to_csv("/broad/hptmp/mkaminen/spleen/regenie/small_spleen/cad_gwas_rsid.tsv", sep="\t", index=False)
#merged = pd.merge(spleen_gwas_sig, cad_gwas_sig, on = "markername", how="inner")

#print(merged.shape)
#merged = merged.rename(columns = {'p_value':'P'})
#merged.to_csv(out_path, sep="\t", index=False)
#print(len(spleen_gwas_sig))
#print(len(cad_gwas_sig))
#print(cad_gwas_sig.pop())
#print(spleen_gwas_sig.pop())
#inter = spleen_gwas_sig.intersection(cad_gwas_sig)
#print(len(inter))
#print(inter)

#with open(out_path, 'w') as fp:
#    fp.write('\n'.join(list(inter)))



