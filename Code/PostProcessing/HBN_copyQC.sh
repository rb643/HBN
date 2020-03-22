#!/bin/bash

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/BIDS
outDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/QC

QC_RegDir=${outDir}/QC_RegDir
QC_SpikeDir=${outDir}/QC_SpikeDir
QC_FDDir=${outDir}/QC_FDDir
QC_TSDir=${outDir}/QC_TSDir

mkdir -p ${QC_RegDir}
mkdir -p ${QC_SpikeDir}
mkdir -p ${QC_FDDir}
mkdir -p ${QC_TSDir}

# # loop through sites
site=Site-CBIC
	for subject in `cat ${site}_subs.txt` ; do
	#for subject in sub-NDARAB458VK9 ; do
  		sub_qc=${dataDir}/${subject}-${site}/proc_func/qc

    		if [ -d ${sub_qc} ];then
					echo "copying qc files - " ${subject} 'from ' ${site}
				  cp ${sub_qc}/QC_Checkreg_${subject}.png ${QC_RegDir}/QC_Checkreg_${subject}.png
          cp ${sub_qc}/QC_Despiked_${subject}.png ${QC_TSDir}/QC_Despiked_${subject}.png
          cp ${sub_qc}/QC_FD_${subject}.png ${QC_FDDir}/QC_FD_${subject}.png
          cp ${sub_qc}/QC_SP_${subject}.png ${QC_SpikeDir}/QC_SP_${subject}.png
				fi
	done

site=Site-RU
	for subject in `cat ${site}_subs.txt` ; do
    sub_qc=${dataDir}/${subject}-${site}/proc_func/qc

      if [ -d ${sub_qc} ];then
        echo "copying qc files - " ${subject} 'from ' ${site}
        cp ${sub_qc}/QC_Checkreg_${subject}.png ${QC_RegDir}/QC_Checkreg_${subject}.png
        cp ${sub_qc}/QC_Despiked_${subject}.png ${QC_TSDir}/QC_Despiked_${subject}.png
        cp ${sub_qc}/QC_FD_${subject}.png ${QC_FDDir}/QC_FD_${subject}.png
        cp ${sub_qc}/QC_SP_${subject}.png ${QC_SpikeDir}/QC_SP_${subject}.png
      fi
	done

site=Site-SI
	for subject in `cat ${site}_subs.txt` ; do
    sub_qc=${dataDir}/${subject}-${site}/proc_func/qc

      if [ -d ${sub_qc} ];then
        echo "copying qc files - " ${subject} 'from ' ${site}
        cp ${sub_qc}/QC_Checkreg_${subject}.png ${QC_RegDir}/QC_Checkreg_${subject}.png
        cp ${sub_qc}/QC_Despiked_${subject}.png ${QC_TSDir}/QC_Despiked_${subject}.png
        cp ${sub_qc}/QC_FD_${subject}.png ${QC_FDDir}/QC_FD_${subject}.png
        cp ${sub_qc}/QC_SP_${subject}.png ${QC_SpikeDir}/QC_SP_${subject}.png
      fi
	done
