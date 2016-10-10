
function [cropped] = cropColumnFromImage(I, mask)

    % retrieve mask indices
    [i_min, i_max, j_min, j_max] = getBoundingBox(mask);
    % crop image in the given area and save it
    cropped = I(i_min : i_max, j_min : j_max);

end