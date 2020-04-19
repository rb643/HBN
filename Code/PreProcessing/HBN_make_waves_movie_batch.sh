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
	for subject in `cat ${site}_subs.txt` ; do
	#for subject in sub-NDARAB458VK9 ; do
  		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01/freesurfer
			rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-movieTP_bold.nii.gz
			t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_acq-HCP_run-01_T1w.nii.gz

    		if [ -e ${freesurfer_dir}/mri/brain.mgz ] && [ -e ${rs_file} ]
				then
					echo "submitted - " ${subject} 'from ' ${site}
					sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/movie/${subject}_${site}_movielog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_movie.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
				fi
	done

site=Site-CBIC
		for subject in `cat ${site}_subs.txt` ; do
		#for subject in sub-NDARAB348EWR ; do
	  		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP/freesurfer/
				rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-movieTP_bold.nii.gz
				t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_acq-HCP_T1w.nii.gz

	    		if [ -e ${freesurfer_dir}/mri/brain.mgz ] && [ -e ${rs_file} ]
					then
						echo "submitted - " ${subject} 'from ' ${site}
						sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/movie/${subject}_${site}_movielog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_movie.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
					fi
		done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
		freesurfer_dir=${dataDir}/${site}/derivatives/${subject}/freesurfer
		rs_file=${dataDir}/${site}/${subject}/func/${subject}_task-movieTP_bold.nii.gz
		t1w_file=${dataDir}/${site}/${subject}/anat/${subject}_acq-HCP_T1w.nii.gz

		if [ -e ${freesurfer_dir}/mri/brain.mgz ] && [ -e ${rs_file} ]
		then
			echo "submitted - " ${subject} 'from ' ${site}
			sbatch --account=BETHLEHEM-SL2-CPU --partition=skylake-himem --output=${dataDir}/logs/movie/${subject}_${site}_movielog.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=04:00:00 --mem=48000 HBN_make_waves_movie.sh ${subject} ${site} ${rs_file} ${freesurfer_dir} ${t1w_file} ${tpatt}
		fi
	done
