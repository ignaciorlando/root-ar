
function [refinedSegmentation] = joinDisconnectedStructures(segmentation)

    % join disconnected structures using a simple closing operation
    refinedSegmentation = imclose(logical(segmentation), ones(3));

end