#!/bin/bash
#
# This script run wavelet despiking
# Inputs:
#sub=$1
#site=$2
#rs_file=$3
#freesurfer_dir=$4
#t1w_file=$5
#tpatt=$6
# Set up variables

# change to overearching directory

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/

# # loop through sites
site=Site-CBIC
	#for subject in `cat rerun_subs.txt` ; do
	for subject in sub-NDARAB458VK9 ; do
  		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01/freesurfer
			rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-rest_run-1_bold.nii.gz
			t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_acq-HCP_run-01_T1w.nii.gz

    		if [ -e ${freesurfer_dir}/mri/brain.mgz ];then
					echo "submitted - " ${subject} 'from ' ${site}
					sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/rs_rerun/${subject}_${site}_rslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_nt_rerun.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
				fi
	done

site=Site-CBIC
		#for subject in `cat rerun_subs.txt` ; do
		for subject in sub-NDARAB458VK9 ; do
	  		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP/freesurfer/
				rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-rest_run-1_bold.nii.gz
				t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_acq-HCP_T1w.nii.gz

	    		if [ -e ${freesurfer_dir}/mri/brain.mgz ];then
						echo "submitted - " ${subject} 'from ' ${site}
						sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/rs_rerun/${subject}_${site}_rslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_nt_rerun.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
					fi
		done

# site=Site-RU
# 	for subject in `cat rerun_subs.txt` ; do
# 		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/freesurfer
# 		rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-rest_run-1_bold.nii.gz
# 		t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_acq-HCP_T1w.nii.gz
#
# 		if [ -e ${freesurfer_dir}/mri/brain.mgz ];then
# 			echo "submitted - " ${subject} 'from ' ${site}
# 			sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/rs_rerun/${subject}_${site}_rslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_nt_rerun.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
# 		fi
# 	done
#
# site=Site-SI
# 	for subject in `cat rerun_subs.txt` ; do
# 		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/freesurfer
# 		rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-rest_bold.nii.gz
# 		t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_T1w.nii.gz
#
# 		if [ -e ${freesurfer_dir}/mri/brain.mgz ];then
# 			echo "submitted - " ${subject} 'from ' ${site}
# 			sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/rs_rerun/${subject}_${site}_rslog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_nt_rerun.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
# 		fi
# 	done
