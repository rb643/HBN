#!/bin/bash
#
# This script submits freesurfer jobs
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory

dataDir=/lustre/archive/q10021/HBN

# loop through sites
site=Site-CBIC
	for subject in `cat ${site}_subs.txt` ; do
  		funcdir=${dataDir}/${site}/${subject}/func
  		surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01/freesurfer/mri
		if [ -e ${funcdir}/"${subject}"_task-rest_run-1_bold.nii.gz ]
   		 then
    			if [ -e ${surfdir}/brain.mgz ]
      			then
			echo ${site} "," ${subject}
       
    			fi
 		fi
	done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
  		funcdir=${dataDir}/${site}/${subject}/func
		surfdir=${dataDir}/${site}/derivatives/${subject}/freesurfer/mri
		if [ -e ${funcdir}/"${subject}"_task-rest_run-1_bold.nii.gz ]
   		 then
    			if [ -e ${surfdir}/brain.mgz ]
      			then
			echo ${site} "," ${subject}
       
    			fi
 		fi
	done


site=Site-SI
	for subject in `cat ${site}_subs.txt` ; do
  		funcdir=${dataDir}/${site}/${subject}/func
		surfdir=${dataDir}/${site}/derivatives/${subject}/freesurfer/mri
		if [ -e ${funcdir}/"${subject}"_task-rest_bold.nii.gz ]
   		 then
    			if [ -e ${surfdir}/brain.mgz ]
      			then
			echo ${site} "," ${subject}
       
    			fi
 		fi
	done
