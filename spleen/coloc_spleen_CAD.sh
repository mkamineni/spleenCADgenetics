#pval_cadmp 2 -R y -binding linear:2
#$ -l h_rt=1:00:00
#$ -l s_rt=1:00:00
#$ -l h_vmem=25G
#$ -j y


source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2
use R-4.1

cdm
Rscript coloc_spleen_CAD.R
