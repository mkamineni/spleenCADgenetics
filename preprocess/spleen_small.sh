#!/bin/bash
#$ -wd /medpop/esp2/mkaminen/logjobs
#$ -l h_rt=72:00:00
#$ -l s_rt=72:00:00
#$ -pe smp 4 -R y -binding linear:4
#$ -l h_vmem=8G
#$ -j y

source /broad/software/scripts/useuse
source ~/.my.bashrc
use GCC-5.2
use R-4.1

Rscript /medpop/esp2/mkaminen/preprocess/spleen_small.R
