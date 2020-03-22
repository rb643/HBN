function [] = wavelet_qc(Inii_orig,Inii_wds)
%
% FUNCTION:     wavelet_qc -- helper to generate some qc plots:

% parse in original and despike images
orig=ParseInNii(Inii_orig);
wds=ParseInNii(Inii_wds);

% pick 4 random voxels between 1 and 100000 and plot the change

figure('Position', [10 10 350 800]);
i=1;
for v = 1:4
    voxel = randi([10000 20000]);
    subplot(8,1,i);
    plot(orig(:,voxel),'k');
    title(['Voxel: ' num2str(voxel)]);
    i=i+1;
    subplot(8,1,i);
    plot(wds(:,voxel),'r');
    i=i+1;
end

saveas(gcf,['QC_Despiked.png'])
