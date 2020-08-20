#!/bin/bash

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/BIDS
outDir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/

QC_Stats=${outDir}/AsegDir
mkdir -p ${QC_Stats}

# # loop through sites
for site in `cat sites.txt`; do
	for subject in `cat QC_subs.txt` ; do
	#for subject in sub-NDARAB458VK9 ; do
  		subdir=${dataDir}/${subject}-${site}/surfaces/${subject}/freesurfer/stats

    		if [ -e ${subdir}/aseg.stats ];then
					echo "copying Aseg stats - " ${subject} 'from ' ${site}
				  cp ${subdir}/aseg.stats ${QC_Stats}/${subject}_aseg.stats
				fi


	done

done
