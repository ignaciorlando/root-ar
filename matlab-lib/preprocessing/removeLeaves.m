
function [withoutLeaves] = removeLeaves(I)

    % erode image to remove the root
    withoutRoot = imerode(I, strel('square',3));
    % dilate the image to recover the leaves
    leaves = imdilate(withoutRoot, strel('square',3));
    % subtract the leaves from the original image
    withoutLeaves = I - leaves;

end