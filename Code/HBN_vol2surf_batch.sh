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
  		surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01
    		if [ -e ${surfdir}/freesurfer/mri/brain.mgz ];then
					echo "submitted - " ${subject}
				sbatch --output=${dataDir}/logs/${subject}_vol2surf.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:10:00 --mem=4000 HBN_vol2surf.sh ${subject} ${surfdir}
    		fi
	done

site=Site-CBIC
		for subject in `cat ${site}_subs.txt` ; do
	  		surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP
				if [ -e ${surfdir}/freesurfer/mri/brain.mgz ];then
					echo "submitted - " ${subject}
				sbatch --output=${dataDir}/logs/${subject}_vol2surf.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:10:00 --mem=4000 HBN_vol2surf.sh ${subject} ${surfdir}
				fi
		done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
		surfdir=${dataDir}/${site}/derivatives/${subject}
    		if [ -e ${surfdir}/freesurfer/mri/brain.mgz ];then
					echo "submitted - " ${subject}
				sbatch --output=${dataDir}/logs/${subject}_vol2surf.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:10:00 --mem=4000 HBN_vol2surf.sh ${subject} ${surfdir}
    		fi
	done

site=Site-SI
	for subject in `cat ${site}_subs.txt` ; do
		surfdir=${dataDir}/${site}/derivatives/${subject}
		if [ -e ${surfdir}/freesurfer/mri/brain.mgz ];then
			echo "submitted - " ${subject}
		sbatch --output=${dataDir}/logs/${subject}_vol2surf.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:10:00 --mem=4000 HBN_vol2surf.sh ${subject} ${surfdir}
		fi
	done
