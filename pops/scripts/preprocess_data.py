import pandas as pd
import os
out_dir = "/medpop/esp2/mkaminen/pops/data/features_raw/"
for direct in ["mouse_heart_control", "human_immune"]:
	data_dir = "/medpop/esp2/mkaminen/pops/gene_features/"+direct
	for filename in os.listdir(data_dir):
		print(filename)
		if ".gz" in filename:
			df= pd.read_csv(data_dir+"/"+filename, sep="\t", compression='gzip')
			df = df.add_prefix(direct+"_")
			df = df.rename(columns = {direct+"_ENSG":"ENSG"})
			df.to_csv(out_dir+direct+"_"+filename[:-3], sep="\t", index=None)
			
