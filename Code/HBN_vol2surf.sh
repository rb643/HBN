#!/bin/bash
#

module load freesurfer

subject=$1
surfdir=$2

tmpDIR=/home/rb643/TempDir

mkdir -p ${tmpDIR}

export SUBJECTS_DIR=${surfdir}
export TMPDIR=${tmpDIR}

recon-all -s freesurfer -qcache -measure thickness -no-isrunning
