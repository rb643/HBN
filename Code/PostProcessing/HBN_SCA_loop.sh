#!/bin/bash
# read the relevant inputs
sub=$1

# load all useful modules
module load fsl/6.0.1
module load matlab/r2019b

# set up the xdg renderer which could be useful later for generating images
xdgDir=/home/rb643/TempDir/${sub}_${site}
mkdir -p ${xdgDir}
export XDG_RUNTIME_DIR=/home/rb643/TempDir/${sub}
# add all the relevant paths in matlab to your path so you can run it from a terminal
export MATLABPATH=/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Code:/home/rb643/matlab/fmri_spt:/home/rb643/matlab/BWT_EXPnew:/home/rb643/matlab/BWT_EXPnew/BWT/:/home/rb643/matlab/fmri_spt/code_bin:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/dwt:/home/rb643/matlab/BWT_EXPnew/third_party/NIfTI:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf:/home/rb643/matlab/BWT_EXPnew/third_party/wmtsa/utils:/home/rb643/matlab/BWT_EXPnew/third_party/cprintf

matlab -nodisplay -r "HBN_SCA_Loop('${sub}');quit"
# check registration
rm -R ${xdgDir}
