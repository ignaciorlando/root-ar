
function [skeleton] = skeletonize(binary)

    % skeletonize using matlab function
    skeleton = bwmorph(binary, 'skel', 8);

end