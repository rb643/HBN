% read the subject list into a table
function [] = HBN_SCA_Loop(subname)

subname = char(subname);  
% setup default dirs
basedir = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/';
rawdir = [basedir,'PostQC_Imaging_M1/'];
denoiseddir = [rawdir,'Denoised/'];
edofdir = [rawdir,'/EDoF'];
outdir = [rawdir,'/rs_out/'];

%% setup ROIs
roilist{1} = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging/roidir/coreg_rs_ROI_leftIC_-6_-31_-10_3mmRadSph_bin_InPrep.nii';
roilist{2} = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging/roidir/coreg_rs_ROI_pSTS_51_-19_-2_6mmRadSph_bin_SCAN2016.nii';
roilist{3} = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging/roidir/coreg_rs_ROI_rIC_6_-31_-10_3mmRadSph_bin_InPrep.nii';
roilist{4} = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging/roidir/coreg_rs_rpSTS_FSL_voice_crss_SCAN2016.nii';
roilist{5} = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging/roidir/coreg_rs_sub-invivo_MNI_left_IC_Sitek2019.nii';
roilist{6} = '/rds/project/rb643-1/rds-rb643-ukbiobank2/Scratch/HBN/Data_Out/PostQC_Imaging/roidir/coreg_rs_sub-invivo_MNI_right_IC_Sitek2019.nii';

%% loop through subject and roi's
restfile = [denoiseddir,'/',subname,'_task-movie_bold_pp.nii.gz'];
edoffile = [edofdir,'/',subname,'_task-movie_bold_EDOF.nii.gz'];

fprintf(strcat('Working on: ', subname));

HBN_SCA_Pipeline(restfile, roilist, edoffile,outdir,subname);

end
