% DSC_mri_toolbox demo

% ------ Load the dataset to be analyzed ---------------------------------
DSC_info   = niftiinfo(fullfile('demo-data','test2.nii.gz'));
DSC_volume = niftiread(DSC_info);

% ------ Set minimum acquistion parameters -------------------------------
TE = 0.014; % 25ms
TR = 0.8;  % 1.55s

% ------ Perform quantification ------------------------------------------ 
% Input   DSC_volume (4D matrix with raw GRE-DSC acquisition)
%         TE         (Echo time)
%         TR         (Repetition time)
% Output  cbv        (3D matrix with standard rCBV values)
%         cbf        (struct with 3D matrices of rCBF values for each method selected)
%         mtt        (struct with 3D matrices of MTT values for each method selected)
%         cbv_lc     (3D matrix with leackage corrected rCBV values)
%         ttp        (3D matrix with leackage corrected Time to Peak values)
%         mask       (3D matrix with computed mask)
%         aif        (struct with AIF extracted with clustering algorithm)
%         conc       (4D matrix with pseudo-concentration values)
%         s0         (3D matrix with S0 estimates from pre-contrast images)

[cbv,cbf,mtt,cbv_lc,ttp,mask,aif,conc,s0]=DSC_mri_core(DSC_volume,TE,TR);

% ------ View Results ----------------------------------------------------
DSC_mri_show_results(cbv_lc,cbf,mtt,ttp,mask,aif,conc,s0);

% ------ Save Results in NIFTI format ------------------------------------
% ------ use header information of the original DSC-MRI sequence ---------
nifti_template = DSC_info;
nifti_template.Datatype='double';
nifti_template.BitsPerPixel=64;
nifti_template.PixelDimensions=nifti_template.PixelDimensions(1:3);
var_outDirName = 'demo-data';

disp('......CBV into nifti......');
nifti_template.ImageSize=size(cbv);
niftiwrite(cbv,fullfile('demo-data','cbv.nii'),nifti_template)
gzip(fullfile('demo-data','cbv.nii'))
delete(fullfile('demo-data','cbv.nii'))


disp('......CBF into nifti......');
nifti_template.ImageSize=size(cbf.osvd.map);
niftiwrite(cbf.svd.map,fullfile('demo-data','cbf_svd.nii'),nifti_template)
niftiwrite(cbf.csvd.map,fullfile('demo-data','cbf_csvd.nii'),nifti_template)
niftiwrite(cbf.osvd.map,fullfile('demo-data','cbf_osvd.nii'),nifti_template)
gzip(fullfile('demo-data','cbf_svd.nii'))
gzip(fullfile('demo-data','cbf_csvd.nii'))
gzip(fullfile('demo-data','cbf_osvd.nii'))
delete(fullfile('demo-data','cbf_svd.nii'))
delete(fullfile('demo-data','cbf_csvd.nii'))
delete(fullfile('demo-data','cbf_osvd.nii'))

disp('......MTT into nifti......');
nifti_template.ImageSize=size(mtt.osvd);
niftiwrite(mtt.svd,fullfile('demo-data','mtt_svd.nii'),nifti_template)
niftiwrite(mtt.csvd,fullfile('demo-data','mtt_csvd.nii'),nifti_template)
niftiwrite(mtt.osvd,fullfile('demo-data','mtt_osvd.nii'),nifti_template)
gzip(fullfile('demo-data','mtt_svd.nii'))
gzip(fullfile('demo-data','mtt_csvd.nii'))
gzip(fullfile('demo-data','mtt_osvd.nii'))
delete(fullfile('demo-data','mtt_svd.nii'))
delete(fullfile('demo-data','mtt_csvd.nii'))
delete(fullfile('demo-data','mtt_osvd.nii'))

disp('......CBV_LC into nifti......');
nifti_template.ImageSize=size(cbv_lc);
niftiwrite(cbv_lc,fullfile('demo-data','cbv_lc.nii'),nifti_template)
gzip(fullfile('demo-data','cbv_lc.nii'))
delete(fullfile('demo-data','cbv_lc.nii'))










