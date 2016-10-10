
clear; clc; close all;

% initialize relevant variables using the configuration script
config_ecimag;

% prepare filepaths for images and masks
images_folder = fullfile(root, 'images');
mask_folder = fullfile(root, 'masks');

% retrieve all image names in the images_folder path
image_filenames = dir_reloaded(images_folder);

% we will iterate now for each column on the scan
for j = 1 : 3
    
    % prepare the mask folder path for this column
    current_mask_folder = strcat(mask_folder, num2str(j));
    % and retrieve masks filenames
    current_mask_filenames = dir_reloaded(current_mask_folder);
    
    fprintf('Processing column %d\n', j);
    
    % for each of the images
    for i = 1 : length(image_filenames)
        
        % retrieve only the filename
        current_image = image_filenames{i};
        current_image(end-3:end) = [];
        
        fprintf('Segmenting image %s\n', current_image); 
        
        % create a path to output current column results
        saveroot = fullfile(savePath, current_image, num2str(j));
        mkdir(saveroot);
        
        % open the image
        original_image = imread(fullfile(images_folder, image_filenames{i}));
        
        % open the mask
        mask = logical(imread(fullfile(current_mask_folder, current_mask_filenames{i})));
        
        % crop image using the mask
        cropped = cropColumnFromImage(original_image, mask);
        imwrite(cropped, fullfile(saveroot,'1_cropped.png'));
        % remove leaves
        [cropped] = removeLeaves(cropped);
        imwrite(cropped, fullfile(saveroot,'2_withoutLeaves.png'));
        % enhance roots using Ricci & Perfetti line detectors
        [cropped] = ricci4roots(cropped);

        % normalize feature to be between 0 and 1
        connected = double(cropped) / max(cropped(:));
        imwrite(connected, fullfile(saveroot,'3_ricci.png'));
        
        % encode data to train the CRF
        [U, P] = prepareDataForCRFs(connected, w_u);
        % segment the image
        segmentation = fullyCRF_wrapped(U, P, w_p, theta_p);
        imwrite(segmentation, fullfile(saveroot,'4_segmentation.png'));

        % join disconnected structures
        [refinedSegmentation] = joinDisconnectedStructures(segmentation);
        imwrite(refinedSegmentation,  fullfile(saveroot,'5_closedSegmentation.png'));

        % skeletonization
        skeleton = skeletonize(refinedSegmentation);
        imwrite(skeleton, fullfile(saveroot,'6_skeletonization.png'));

        % remove isolated structures with less than 20 pixels
        [cleanedSkeleton] = cleanSkeleton(skeleton);
        imwrite(cleanedSkeleton, fullfile(saveroot,'7_finalSkeletonization.png'));
        
    end
    
    
end









