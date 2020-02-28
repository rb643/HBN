#!/bin/bash
sub=$1
site=$2
rs_file=$3
freesurfer_dir=$4
t1w_file=$5
tpatt=$6

# load all defaults
module load fsl/6.0.1
module load matlab/r2019b
module load afni/17.0.00
module load freesurfer/6.0.0

# set up the xdg renderer
xdgDir=/home/rb643/TempDir/${sub}_${site}
mkdir -p ${xdgDir}
export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}_${site}

export MATLABPATH=/home/rb643/matlab/fmri_spt:/home/rb643/matlab/BWT_EXPnew:/home/rb643/matlab/BWT_EXPnew/BWT/:/home/rb643/matlab/fmri_spt/code_bin:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/dwt:/home/rb643/matlab/BWT_EXPnew/third_party/NIfTI:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/utils:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf

# setup directories
topdir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/
datadir=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/${site}

anatdir=${topdir}/BIDS/${sub}/anat/
procdir=${topdir}/BIDS/${sub}/xtmp/
procfunc=${topdir}/BIDS/${sub}/proc_func/
qcfunc=${topdir}/BIDS/${sub}/proc_func/qc
surfacedir=${topdir}/BIDS/${sub}/surfaces/${sub}

mkdir -p ${procdir}
mkdir -p ${procfunc}
mkdir -p ${qcfunc}
mkdir -p ${anatdir}
mkdir -p ${surfacedir}

# check t patterns
echo $tpatt

# copy and convert freesurfer
mri_convert --out_orientation RAS  -rt nearest --reslice_like ${t1w_file} ${freesurfer_dir}/mri/brain.mgz ${procdir}/${sub}_brain.nii.gz

#cp ${rs_dir}/${sub}_${ses}_task-rest_acq-645_bold.nii.gz ${base_dir}/${sub}_${ses}_task-rest_acq-645_bold.nii.gz
cp -R ${freesurfer_dir}/ ${surfacedir}/
cp ${t1w_file} ${anatdir}/${sub}_T1w.nii.gz
cp ${rs_file} ${procdir}/${sub}_task-rest_bold.nii

cd ${procdir}/
# run wavelet code
python /home/rb643/matlab/fmri_spt/speedyppX.py -d ${procdir}/${sub}_task-rest_bold.nii -a ${procdir}/${sub}_brain.nii.gz -o --wds --SP --EDOF --rmot --rmotd --rcsf --nobandpass --zeropad=100 --ss=MNI152 --qwarp --csftemp=MNI152 --csfpeel=6 --tpattern=${tpatt} --OVERWRITE

# generate some QC plots
source /home/rb643/Py37/bin/activate
echo "------- generating QC plots -------"
cd ${procdir}/
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/FD.py ${sub}_task-rest_bold_motion.1D
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/SP.py ${sub}_task-rest_bold_SP.txt

matlab -nodisplay -r "wavelet_qc('spp.${sub}_task-rest_bold/${sub}_task-rest_bold_sm.nii.gz','spp.${sub}_task-rest_bold/${sub}_task-rest_bold_wds.nii.gz');quit"
# check registration
echo "------- registration checks -------"
fslmaths ${sub}_task-rest_bold_pp.nii.gz -Tmean mean_spp.nii.gz

xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/CheckReg.py ${sub}_brain.nii.gz mean_spp.nii.gz

# copy out needed files

echo "------- copying needed files -------"
cp QC_checkreg.png ${qcfunc}/QC_Checkreg_${sub}.png
cp QC_Despiked.png ${qcfunc}/QC_Despiked_${sub}.png
cp QC_FD.png ${qcfunc}/QC_FD_${sub}.png
cp QC_SP.png ${qcfunc}/QC_SP_${sub}.png

cp ${sub}_task-rest_bold_EDOF.nii.gz ${procfunc}/${sub}_task-rest_bold_EDOF.nii.gz
cp ${sub}_task-rest_bold_motion.1D ${procfunc}/${sub}_task-rest_bold_motion.1D
cp ${sub}_task-rest_bold_motion_fd.txt ${procfunc}/${sub}_task-rest_bold_motion_fd.txt
cp ${sub}_task-rest_bold_pp.nii.gz ${procfunc}/${sub}_task-rest_bold_pp.nii.gz
cp ${sub}_task-rest_bold_SP.txt ${procfunc}/${sub}_task-rest_bold_bold_SP.txt
cp _spp_${sub}_task-rest_bold.sh ${procfunc}/_spp_${sub}_task-rest_bold.sh

# clean-up
echo "------- cleaning up -------"
rm -R ${xdgDir}
rm -R ${procdir}
