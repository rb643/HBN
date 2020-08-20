#!/bin/bash
#
# This script run wavelet despiking
# Inputs:
#subnamem=$1
#site=$2
#rs_file=$3
#freesurfer_dir=$4
#t1w_file=$5
#tpatt=$6
# Set up variables

# change to overearching directory

dataDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging_M1/Denoised/
logdir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/logs/SCA

# # loop through sites
for subname in `cat HBN_sublist.txt` ; do
#for subname in sub-NDARAA075AMK ; do
    		if [ -e ${dataDir}/${subname}'_task-movie_bold_pp.nii.gz' ];then
					echo "submitted - " ${subname}
					sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${logdir}/${subname}_scalog_m1.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:30:00 --mem=12000 HBN_SCA_loop.sh ${subname}
				fi
done
