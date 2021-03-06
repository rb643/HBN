#!/bin/bash
# read the relevant inputs
sub=$1
site=$2
rs_file=$3
freesurfer_dir=$4
t1w_file=$5
tpatt=$6

# load all useful modules
module load fsl/6.0.1
module load matlab/r2019b
module load afni/17.0.00
module load freesurfer/6.0.0

# set up the xdg renderer which could be useful later for generating images
xdgDir=/home/rb643/TempDir/${sub}_${site}
mkdir -p ${xdgDir}
export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}_${site}
# add all the relevant paths in matlab to your path so you can run it from a terminal
export MATLABPATH=/home/rb643/matlab/fmri_spt:/home/rb643/matlab/BWT_EXPnew:/home/rb643/matlab/BWT_EXPnew/BWT/:/home/rb643/matlab/fmri_spt/code_bin:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/dwt:/home/rb643/matlab/BWT_EXPnew/third_party/NIfTI:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/utils:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf

# setup directories in BIDS format
topdir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/
datadir=/home/rb643/rds/rds-rb643-ukbiobank2/Scratch/HBN/${site}

anatdir=${topdir}/BIDS/${sub}-${site}/anat/
procdir=${topdir}/BIDS/${sub}-${site}/xtmp/
procfunc=${topdir}/BIDS/${sub}-${site}/proc_movie2/
qcfunc=${topdir}/BIDS/${sub}-${site}/proc_movie2/qc
surfacedir=${topdir}/BIDS/${sub}-${site}/surfaces/${sub}

mkdir -p ${procdir}
mkdir -p ${procfunc}
mkdir -p ${qcfunc}
mkdir -p ${anatdir}
mkdir -p ${surfacedir}

# check t patterns
echo $tpatt

# copy and convert freesurfer
mri_convert --out_orientation RAS  -rt nearest --reslice_like ${t1w_file} ${freesurfer_dir}/mri/brain.mgz ${procdir}/${sub}_brain.nii.gz

# copy relevant files to a uniform naming structure
cp -R ${freesurfer_dir}/ ${surfacedir}/
cp ${t1w_file} ${anatdir}/${sub}_T1w.nii.gz
cp ${rs_file} ${procdir}/${sub}_task-movie_bold.nii.gz
cp ${rs_file} ${procfunc}/${sub}_task-movie_bold.nii.gz

cd ${procdir}/
# run wavelet code
python /home/rb643/matlab/fmri_spt/speedyppX.py -d ${sub}_task-movie_bold.nii.gz -a ${sub}_brain.nii.gz -o --wds --SP --EDOF --rmot --rmotd --rcsf --nobandpass --zeropad=100 --ss=MNI152 --qwarp --csftemp=MNI152 --csfpeel=6 --tpattern=${tpatt} --OVERWRITE

# generate some QC plots
source /home/rb643/Py37/bin/activate
echo "------- generating QC plots -------"
cd ${procdir}/
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/FD.py ${sub}_task-movie_bold_motion.1D
xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/SP.py ${sub}_task-movie_bold_SP.txt

matlab -nodisplay -r "wavelet_qc('spp.${sub}_task-movie_bold/${sub}_task-movie_bold_sm.nii.gz','spp.${sub}_task-movie_bold/${sub}_task-movie_bold_wds.nii.gz');quit"
# check registration
echo "------- registration checks -------"
fslmaths ${sub}_task-movie_bold_pp.nii.gz -Tmean mean_spp.nii.gz

xvfb-run --server-args="-screen 0 1024x768x24" python /home/rb643/matlab/fmri_spt/code_bin/CheckReg.py ${sub}_brain_sppdo_atnl.nii.gz mean_spp.nii.gz

# copy out needed files

echo "------- copying needed files -------"
cp QC_checkreg.png ${qcfunc}/QC_Checkreg_${sub}.png
cp QC_Despiked.png ${qcfunc}/QC_Despiked_${sub}.png
cp QC_FD.png ${qcfunc}/QC_FD_${sub}.png
cp QC_SP.png ${qcfunc}/QC_SP_${sub}.png

cp ${sub}_task-movie_bold_EDOF.nii.gz ${procfunc}/${sub}_task-movie_bold_EDOF.nii.gz
cp ${sub}_task-movie_bold_motion.1D ${procfunc}/${sub}_task-movie_bold_motion.1D
cp ${sub}_task-movie_bold_motion_fd.txt ${procfunc}/${sub}_task-movie_bold_motion_fd.txt
cp ${sub}_task-movie_bold_pp.nii.gz ${procfunc}/${sub}_task-movie_bold_pp.nii.gz
cp ${sub}_task-movie_bold_SP.txt ${procfunc}/${sub}_task-movie_bold_bold_SP.txt
cp ${sub}_brain_sppdo_atnl.nii.gz ${procfunc}/${sub}_brain_sppdo_atnl.nii.gz
cp ${sub}_brain_sppdo_at.nii.gz ${procfunc}/${sub}_brain_sppdo_at.nii.gz
cp _spp_${sub}_task-movie_bold.sh ${procfunc}/_spp_${sub}_task-movie_bold.sh

# clean-up
echo "------- cleaning up -------"
rm -R ${xdgDir}
rm -R ${procdir}
