function [] = HBN_SCA_Pipeline(rest, roi, edof, prefix)

%% INPUT
% rest      -       nii/gz file containing the functional timeseries
% roi       -       nii/gz file containing the seed ROI in the same
%                   voxelspace
% edof      -       Estimated degrees of Freedom map for all wavelet bands
% prefix    -       string prefix for the output name

%% OUTPUT
% writes out a Niftii zmap that should be EDoF and FDR corrected..

%% Requirements
% requires fmri_spt (brainwavelet.org) toolbox for its read and write nifti functions
% requires the wavelet toolbox for wavelet bandpass filtering

% Parse in timeseries nifiti
[Rest,InfoRest] = ParseInNii(rest,'compress',1);
%% Make sure ROI and timeseries are in the same space!!!
% Parse in mask/ROI
[ROI,InfoROI] = ParseInNii(roi,'compress',1);
% Parse in EDoF map
[EDoF,InfoEDoF] = ParseInNii(edof,'compress',1);
% Store rest name
outname = [prefix rest];
% Create an output structure with the correct indices and size
InfoOut = InfoROI;
InfoOut.tsInd = InfoRest.tsInd;

%% Operations
% 1. Run DWT on timeseries to bandpass
% Run DWT for 8 levels
[WJt, VJt, att] = modwt(Rest, 'la8', 8, 'circular');
% Set all levels except for relevant ones to 0 - for relevant ones you need to compute the bands corresponding to the TR
WJt(:,[1 5 6 7 8],:) = 0;
% Sum up
WJt = squeeze(sum(WJt,2));

% Make sure the EDoF includes the same scales
EDoF([1 5 6 7 8],:) = 0;
EDoF = sum(EDoF);

% 2. Extract average ROI timeseries
idxs = arrayfun(@(x)find(InfoROI.tsInd==x),InfoRest.tsInd, 'UniformOutput', 0);
idxs = cell2mat(idxs);
seedV = WJt(:,idxs);
seedTS = mean(seedV,2);

% 3. Run pearson correlation for ROI and tranform to fischer right away, multiply by EDoF to weight by DoF
for ir = 1:size(WJt,2)
    [r p] = corrcoef(seedTS,squeeze(WJt(:,ir)));
    R(ir) = fisherz(r(1,2))*sqrt(EDoF(ir)-3);
    P(ir) = fisherz(p(1,2))*sqrt(EDoF(ir)-3);
end

% 4. Convert resulting pearsons:  run FDR
% correction
zmap = R;
pmap = normcdf(-abs(zmap),0,1);
[p_fdr, p_masked] = fdr(pmap, 0.05, 'nonParametric');
zmap(p_masked==0) = 0;

% 5. Write out resulting map to nifti
WriteOutNii(zmap,outname,InfoOut)

end
