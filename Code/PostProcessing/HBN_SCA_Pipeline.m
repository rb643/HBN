% Script for seed-based ROI analyses from Richard Bethlehem
% For anaylses of rs fMRI and movie data from CMIHBN

%8 May 2020
%HBN/Code/PostProcessing/HBN_SCA_Pipeline.m
%@rb643 rb643 updates, SCA and Movie 613f59e 19 days ago
%66 lines (55 sloc) 2.1 KB

function [] = HBN_SCA_Pipeline(restfile, roilist, edoffile,outdir,subname)

%% INPUT
% restfile  -       nii/gz file containing the functional timeseries
% roifile   -       nii/gz file containing the seed ROI in the same > bin
%                   voxelspace
% edoffile  -       Estimated degrees of Freedom map for all wavelet bands
% outfile   -       string prefix for the output name

%% OUTPUT
% writes out a Niftii zmap that should be EDoF and FDR corrected..

%% Requirements
% requires fmri_spt (brainwavelet.org) toolbox for its read and write nifti
% functions > path to SPM
% requires the wavelet toolbox for wavelet bandpass filtering

% Parse in timeseries nifiti > rest (4D x y z over time); Info Rest =
% header
[Rest,InfoRest] = ParseInNii(restfile,'compress',0);

%% Make sure ROI and timeseries are in the same space!!!

% Parse in EDoF map (4d estimated df within each wavelet band)
[EDoF,InfoEDoF] = ParseInNii(edoffile,'compress',0);



%% Operations

% 1. Run DWT on timeseries to bandpass
% Run DWT for 8 levels
[WJt, VJt, att] = modwt(Rest, 'la8', 8, 'circular');%wavelet decompos > get 4D tim series to 8 bands
% Set all levels except for relevant ones to 0 - for relevant ones you need to compute the bands corresponding to the TR
WJt(:,[1 2 7 8],:) = 0; %check formula frequency range > rest to 0
% Sum up
WJt = squeeze(sum(WJt,2));%sums up fr s we keep% Make sure the EDoF includes the same scales
EDoF([1 2 7 8],:) = 0; %same as for above
EDoF = sum(EDoF,1);

for rrs = 1:length(unique(roilist))
    
    % Parse in mask/ROI and create outfile
    roifile = char(roilist{rrs});
    outfile = [outdir,'/',subname,'_roi_',num2str(rrs),'_.nii.gz'];
    
    [ROI,InfoROI] = ParseInNii(roifile,'compress',0);
	% Create an output structure with the correct indices and size
	InfoOut = InfoEDoF; %same info and var as ROI, 3D
	InfoOut.dim = [InfoEDoF.dim(1:3),1]; %remove one dimension

    ROI(isnan(ROI))=0; % remove NANs
    
    % 2. Extract average ROI timeseries
    seedV = WJt(:,logical(ROI));%all voxels within roi, mean time series
    seedTS = mean(seedV,2);
    
    % 3. Run pearson correlation for ROI and tranform to fischer right away, multiply by EDoF to weight by DoF
    for ir = 1:size(WJt,2)%every vpxel roi with ts each voxel
        [r p] = corrcoef(seedTS,squeeze(WJt(:,ir)));%squeeze > vectro for corr over column
        R(ir) = fisherz(r(1,2))*sqrt(EDoF(ir)-3);%adjusting corr by df, same for p; z-scoring
        P(ir) = fisherz(p(1,2))*sqrt(EDoF(ir)-3);
    end
    
    % 4. Convert resulting pearsons:  run FDR
    % correction
    zmap = R;%voxel-wise r for roi
    %pmap = normcdf(-abs(zmap),0,1);%p val across all voxel roi
    %[p_fdr, p_masked] = FDR(pmap, 0.05);%adjusts all ps
    %zmap(p_masked==0) = 0;%only sign values survive
    fprintf(strcat("\n Working on ROI: ", num2str(rrs), " out of ", num2str(length(unique(roilist)))));
    % 5. Write out resulting map to nifti
    WriteOutNii(zmap,outfile,InfoOut)%z-scores into nii
end % end of roi-list

end %end of function

% Â© 2020 GitHub, Inc.
