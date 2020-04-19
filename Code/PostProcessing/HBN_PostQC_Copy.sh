#!/bin/bash

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/BIDS
outDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/

QC_Stats=${outDir}/PostQC_Stats
mkdir -p ${QC_Stats}/FD/
mkdir -p ${QC_Stats}/SP/
mkdir -p ${QC_Stats}/Motion/

QC_Imaging=${outDir}/PostQC_Imaging
mkdir -p ${QC_Imaging}/EDoF/
mkdir -p ${QC_Imaging}/Denoised/

# # loop through sites
for site in `cat sites.txt`; do
	for subject in `cat QC_subs.txt` ; do
	#for subject in sub-NDARAB458VK9 ; do
  		subdir=${dataDir}/${subject}-${site}/proc_func

    		if [ -e ${subdir}/${subject}_task-rest_bold_bold_SP.txt ];then
					echo "copying qc stats - " ${subject} 'from ' ${site}
				  cp ${subdir}/${subject}_task-rest_bold_bold_SP.txt ${QC_Stats}/SP/${subject}_task-rest_bold_bold_SP.txt
          cp ${subdir}/${subject}_task-rest_bold_motion_fd.txt ${QC_Stats}/FD/${subject}_task-rest_bold_motion_fd.txt
          cp ${subdir}/${subject}_task-rest_bold_motion.1D ${QC_Stats}/Motion/${subject}_task-rest_bold_motion.1D
				fi

        if [ -e ${subdir}/${subject}_task-rest_bold_pp.nii.gz ];then
					echo "copying imaging - " ${subject} 'from ' ${site}
          cp ${subdir}/${subject}_task-rest_bold_pp.nii.gz ${QC_Imaging}/Denoised/${subject}_task-rest_bold_pp.nii.gz
          cp ${subdir}/${subject}_task-rest_bold_EDOF.nii.gz ${QC_Imaging}/EDoF/${subject}_task-rest_bold_EDOF.nii.gz
        fi


	done

done
