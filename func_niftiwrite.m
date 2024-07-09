% auth: shreya jain
% Date: 3rd May, 2013


function [] = func_niftiwrite(arg_nifti_template, arg_mapDetails, arg_arr_outFileNames, arg_outDirName, arg_str)
disp(arg_str);
arg_nifti_template.ImageSize=size(arg_mapDetails);


    if  ~isempty(arg_arr_mapDetails) && ~isempty(arg_arr_outFileNames)
        disp ("......Length check passed......")
%         for fn = arg_arr_outFileNames
            niftiwrite(arg_mapDetails.svd.map, fullfile(arg_outDirName,fn), arg_nifti_template);
            niftiwrite(arg_mapDetails.osvd.map, fullfile(arg_outDirName,fn), arg_nifti_template);
            niftiwrite(arg_mapDetails.csvd.map, fullfile(arg_outDirName,fn), arg_nifti_template);
            disp("......niftiwrite on " , fn ," completed......")
            gzip(fullfile(arg_outDirName,fn));
            disp("......gzip done......")
            delete(fullfile(arg_outDirName,fn));
            disp("......Deletion completed......")
%             end
    end
end


