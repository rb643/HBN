#!/bin/bash

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/BIDS
outDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/QC

QC_Stats=${outDir}/QC_Stats
mkdir -p ${QC_Stats}/FD/
mkdir -p ${QC_Stats}/SP/
mkdir -p ${QC_Stats}/Motion/

# # loop through sites
site=Site-CBIC
	for subject in `cat ${site}_subs.txt` ; do
	#for subject in sub-NDARAB458VK9 ; do
  		subdir=${dataDir}/${subject}-${site}/proc_func

    		if [ -e ${subdir}/${subject}_task-rest_bold_bold_SP.txt ];then
					echo "copying qc stats - " ${subject} 'from ' ${site}
				  cp ${subdir}/${subject}_task-rest_bold_bold_SP.txt ${QC_Stats}/SP/${subject}_task-rest_bold_bold_SP.txt
          cp ${subdir}/${subject}_task-rest_bold_motion_fd.txt ${QC_Stats}/FD/${subject}_task-rest_bold_motion_fd.txt
          cp ${subdir}/${subject}_task-rest_bold_motion.1D ${QC_Stats}/Motion/${subject}_task-rest_bold_motion.1D
				fi
	done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
    subdir=${dataDir}/${subject}-${site}/proc_func

      if [ -e ${subdir}/${subject}_task-rest_bold_bold_SP.txt ];then
        echo "copying qc stats - " ${subject} 'from ' ${site}
        cp ${subdir}/${subject}_task-rest_bold_bold_SP.txt ${QC_Stats}/SP/${subject}_task-rest_bold_bold_SP.txt
        cp ${subdir}/${subject}_task-rest_bold_motion_fd.txt ${QC_Stats}/FD/${subject}_task-rest_bold_motion_fd.txt
        cp ${subdir}/${subject}_task-rest_bold_motion.1D ${QC_Stats}/Motion/${subject}_task-rest_bold_motion.1D
      fi
	done

site=Site-SI
	for subject in `cat ${site}_subs.txt` ; do
    subdir=${dataDir}/${subject}-${site}/proc_func

      if [ -e ${subdir}/${subject}_task-rest_bold_bold_SP.txt ];then
        echo "copying qc stats - " ${subject} 'from ' ${site}
        cp ${subdir}/${subject}_task-rest_bold_bold_SP.txt ${QC_Stats}/SP/${subject}_task-rest_bold_bold_SP.txt
        cp ${subdir}/${subject}_task-rest_bold_motion_fd.txt ${QC_Stats}/FD/${subject}_task-rest_bold_motion_fd.txt
        cp ${subdir}/${subject}_task-rest_bold_motion.1D ${QC_Stats}/Motion/${subject}_task-rest_bold_motion.1D
      fi
	done
