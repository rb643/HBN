#!/bin/bash
#
# This script submits rr480's parcellation script
#
#
# Set up variables

# change to overearching directory

dataDir=/lustre/archive/q10021/HBN

# loop through sites
site=Site-CBIC
	for subject in `cat ${site}_subs.txt` ; do
  		surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01/freesurfer/mri
    		if [ -e ${surfdir}/brain.mgz ];then
				if [ ! -e ${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01/freesurfer/parcellation/sjh_seq.nii.gz ];then
					echo ${subject} ' Running!'
	            			sbatch /home/rr480/Code/MATLAB/parcellation/parcellation2individuals_Ind.sh freesurfer ${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01/
				else
					echo ${subject} ' Completed!'
				fi
    		fi
	done

site=Site-CBIC
		for subject in `cat ${site}_subs.txt` ; do
	  		surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP/freesurfer/mri
	    		if [ -e ${surfdir}/brain.mgz ];then
					if [ ! -e ${dataDir}/${site}/derivatives/${subject}/T1w_HCP/freesurfer/parcellation/sjh_seq.nii.gz ];then
						echo ${subject} ' Running!'
		            			sbatch /home/rr480/Code/MATLAB/parcellation/parcellation2individuals_Ind.sh freesurfer ${dataDir}/${site}/derivatives/${subject}/T1w_HCP/
					else
						echo ${subject} ' Completed!'
					fi
	    		fi
		done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
		surfdir=${dataDir}/${site}/derivatives/${subject}/freesurfer/mri
    		if [ -e ${surfdir}/brain.mgz ];then
       	if [ ! -e ${dataDir}/${site}/derivatives/${subject}/freesurfer/parcellation/sjh_seq.nii.gz ];then
					echo ${subject} ' Running!'
	            			sbatch /home/rr480/Code/MATLAB/parcellation/parcellation2individuals_Ind.sh freesurfer ${dataDir}/${site}/derivatives/${subject}/
				else
					echo ${subject} ' Completed!'
				fi
    		fi
	done

site=Site-SI
	for subject in `cat ${site}_subs.txt` ; do
		surfdir=${dataDir}/${site}/derivatives/${subject}/freesurfer/mri
    		if [ -e ${surfdir}/brain.mgz ]; then
       	if [ ! -e ${dataDir}/${site}/derivatives/${subject}/freesurfer/parcellation/sjh_seq.nii.gz ];then
					echo ${subject} ' Running!'
	            			sbatch /home/rr480/Code/MATLAB/parcellation/parcellation2individuals_Ind.sh freesurfer ${dataDir}/${site}/derivatives/${subject}/
				else
					echo ${subject} ' Completed!'
				fi
    			fi
	done
