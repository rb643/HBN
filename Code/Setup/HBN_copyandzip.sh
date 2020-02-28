#!/bin/bash
#
# This script copy files from a specific directory to an output directory
#
#
# Set up variables

# change to overearching directory

dataDir=/lustre/archive/q10021/HBN
transferdir=$dataDir/Data_Out/CT2Surf_5mm/

mkdir -p ${transferdir}

# loop through sites
site=Site-CBIC
	for subject in `cat ${site}_subs.txt` ; do
  		surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP_run-01
    		if [ -e ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ];then
			echo "copying - " ${subject}
			cp ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_lh.thickness.fwhm5.fsaverage.mgh
			cp ${surfdir}/freesurfer/surf/rh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_rh.thickness.fwhm5.fsaverage.mgh
    		fi
	done

site=Site-CBIC
	for subject in `cat ${site}_subs.txt` ; do
	  	surfdir=${dataDir}/${site}/derivatives/${subject}/T1w_HCP
		if [ -e ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ];then
			echo "copying - " ${subject}
			cp ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_lh.thickness.fwhm5.fsaverage.mgh
			cp ${surfdir}/freesurfer/surf/rh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_rh.thickness.fwhm5.fsaverage.mgh
		fi
	done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
		surfdir=${dataDir}/${site}/derivatives/${subject}
    		if [ -e ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ];then
			echo "copying - " ${subject}
			cp ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_lh.thickness.fwhm5.fsaverage.mgh
			cp ${surfdir}/freesurfer/surf/rh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_rh.thickness.fwhm5.fsaverage.mgh
    		fi
	done

site=Site-SI
	for subject in `cat ${site}_subs.txt` ; do
		surfdir=${dataDir}/${site}/derivatives/${subject}
		if [ -e ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ];then
			echo "copying - " ${subject}
			cp ${surfdir}/freesurfer/surf/lh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_lh.thickness.fwhm5.fsaverage.mgh
			cp ${surfdir}/freesurfer/surf/rh.thickness.fwhm5.fsaverage.mgh ${transferdir}/${subject}_rh.thickness.fwhm5.fsaverage.mgh
		fi
	done
