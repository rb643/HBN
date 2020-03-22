## Code for processing Healthy Brain Network Data

The repository contains all code used to pre-process HBN data. It uses the [wavelet toolbox](http://www.brainwavelet.org/) to process both resting-state and movie-watching fmri data.


### Pre-processing
In the current pipeline we used the already generated HCP freesurfer pipeline made available by the Child Mind Institure for this dataset. Freesurfer extracted brains are used as the anatomical input for the speedyPP wavelet pipeline. In the current version no smoothing was included in the pipeline as our protocol may require different smoothing for cortical and subcortical seed-based connectivity analyses. Normalisation to MNI space was done using non-linear warping. During processing initial input structure is also converted to a BIDS compatible output structure.

- **[HBN_makes_waves_batch.sh](/Code/PreProcessing/HBN_makes_waves_batch.sh)**: script used to submit the pipeline for each subject as a batch job to the HPC cluster    
- **[HBN_make_waves_nt.sh](/Code/PreProcessing/HBN_make_waves_nt.sh)**: full pipeline including folder setup, processing and generating various qc plots

### Quality control
In addition some minimal quality control scripts are added:

- **[CheckReg.py](/Code/Utils/CheckReg.py)**: Generates a screenshot of the alignment between the mean denoised functional image and the normalised anatomical one    
- **[wavelet_qc.m](/Code/Utils/wavelet_qc.m)**: Generates a plot of time-series for 3 random voxels pre and post denoising    
- **[FD.py](/Code/Utils/FD.py)**: plots the framewise displacement    
- **[SP.py](/Code/Utils/SP.py)**: plots the percentage of removed spikes     
