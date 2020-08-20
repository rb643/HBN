#!/bin/bash
# read the relevant inputs

dataDir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/

# setup directories in BIDS format
topdir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/

source /home/rb643/Py37/bin/activate
module load fsl/6.0.1
module load matlab/r2019b
export MATLABPATH=/home/rb643/matlab/fmri_spt:/home/rb643/matlab/BWT_EXPnew:/home/rb643/matlab/BWT_EXPnew/BWT/:/home/rb643/matlab/fmri_spt/code_bin:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/dwt:/home/rb643/matlab/BWT_EXPnew/third_party/NIfTI:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/utils:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf

# set

site=$1
for sub in `cat allsubs.txt` ; do
#for sub in sub-NDARYM334BZ5 ; do
  xdgDir=/home/rb643/TempDir/${sub}_${site}
  mkdir -p ${xdgDir}
  export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}_${site}

    procfunc=${topdir}/BIDS/${sub}-${site}/proc_movie2/
    qcfunc=${topdir}/BIDS/${sub}-${site}/proc_movie2/qc

if [ -d ${procfunc} ];then
    cd ${procfunc}
    echo "QC directory exists for: " ${sub}
  if [ ! -e ${qcfunc}/QC_FD_${sub}.png ];then
    # generate some QC plots
    echo "------- generating FD plots for: " ${sub} "-------"
    xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/FD.py ${sub}_task-movie_bold_motion.1D
    mv QC_FD.png ${qcfunc}/QC_FD_${sub}.png
  fi

  if [ ! -e ${qcfunc}/QC_SP_${sub}.png ];then
    echo "------- generating SP plots for: " ${sub} "-------"
    xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/SP.py ${sub}_task-movie_bold_bold_SP.txt
    mv QC_SP.png ${qcfunc}/QC_SP_${sub}.png
  fi

  if [ ! -e ${qcfunc}/QC_Despiked_${sub}.png ];then
    echo "------- generating Despike plots for: " ${sub} "-------"
    matlab -nodisplay -r "wavelet_qc('spp.${sub}_task-movie_bold/${sub}_task-movie_bold_sm.nii.gz','spp.${sub}_task-movie_bold/${sub}_task-movie_bold_wds.nii.gz');quit"
    mv QC_Despiked.png ${qcfunc}/QC_Despiked_${sub}.png
  fi

  #if [ ! -e ${qcfunc}/QC_Checkreg_${sub}.png ];then
    echo "------- registration checks: " ${sub} " -------"
    fslmaths ${sub}_task-movie_bold_EDOF.nii.gz -Tmean mean_edof.nii.gz
    xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/CheckReg.py ${sub}_brain_sppdo_atnl.nii.gz mean_edof.nii.gz
    mv QC_checkreg.png ${qcfunc}/QC_Checkreg_${sub}.png
    rm mean_edof.nii.gz
  #fi

fi

rm -R $xdgDir
done
