import pandas as pd

phenos = "/medpop/esp2/mzekavat/UKBB/ukbb_PhenoFile.ALL_500k.UpdatedIncdPhenos_202020.txt"
cad_coh = "/broad/hptmp/mkaminen/spleen/regenie/spleen/CADcohort_all_demo_rad.csv"

cols = ["id", "BMI", "Hypertension", "Triglycerides", "LDL.direct", "Hypercholesterolemia", "ever_smoked", "SBP", "HDL.cholesterol", "Total.Cholesterol"]
phenos = pd.read_csv(phenos, sep = "\t", usecols = cols)
phenos = phenos.rename(columns = {"id":"ID"})
print(phenos.shape)
cad_coh = pd.read_csv(cad_coh)
print(cad_coh.shape)
print(len(cad_coh.ID.unique()))

merged = cad_coh.merge(phenos, on = "ID", how = "left")
print(merged.shape)
for col in ["BMI", "Hypertension", "Triglycerides", "LDL.direct", "SBP", "HDL.cholesterol", "Total.Cholesterol"]:
	print(col)
	print(merged[col].median())
	print(merged[col].quantile([0.25,0.75]))


for col in ["Hypercholesterolemia", "ever_smoked"]:
	print(col)
	print(merged[col].value_counts())





