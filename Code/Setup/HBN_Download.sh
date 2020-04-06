#!/bin/bash
#

source /home/rb643/py360/bin/activate

bucket=s3://fcp-indi/data/Projects/HBN/MRI/
outdir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/temp

mkdir -p ${outdir}

# loop through sites
site=Site-CBIC
  mkdir -p ${outdir}/${site}/derivatives
	for subject in `cat ${site}_subs_R8.txt` ; do
    subject='sub-'${subject}
    mkdir -p ${outdir}/${site}/${subject}
    echo "downloding derivatives for: " ${subject}
    aws s3 cp s3://fcp-indi/data/Projects/HBN/MRI/${site}/derivatives/${subject} ${outdir}/${site}/derivatives/${subject} --recursive --no-sign-request
    echo "downloding raw for: " ${subject}
    aws s3 cp s3://fcp-indi/data/Projects/HBN/MRI/${site}/${subject} ${outdir}/${site}/${subject} --recursive --no-sign-request
	done

site=Site-RU
  mkdir -p ${outdir}/${site}/derivatives
	for subject in `cat ${site}_subs_R8.txt` ; do
    subject='sub-'${subject}
    mkdir -p ${outdir}/${site}/${subject}
    echo "downloding derivatives for: " ${subject}
    aws s3 cp s3://fcp-indi/data/Projects/HBN/MRI/${site}/derivatives/${subject} ${outdir}/${site}/derivatives/${subject} --recursive --no-sign-request
    echo "downloding raw for: " ${subject}
    aws s3 cp s3://fcp-indi/data/Projects/HBN/MRI/${site}/${subject} ${outdir}/${site}/${subject} --recursive --no-sign-request
	done

site=Site-CUNY
  mkdir -p ${outdir}/${site}/derivatives
	for subject in `cat ${site}_subs_R8.txt` ; do
    subject='sub-'${subject}
    mkdir -p ${outdir}/${site}/${subject}
    echo "downloding derivatives for: " ${subject}
    aws s3 cp s3://fcp-indi/data/Projects/HBN/MRI/${site}/derivatives/${subject} ${outdir}/${site}/derivatives/${subject} --recursive --no-sign-request
    echo "downloding raw for: " ${subject}
    aws s3 cp s3://fcp-indi/data/Projects/HBN/MRI/${site}/${subject} ${outdir}/${site}/${subject} --recursive --no-sign-request
	done
