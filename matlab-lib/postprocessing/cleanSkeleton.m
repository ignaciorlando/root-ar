
function [cleanedSkeleton] = cleanSkeleton(skeletonization)

    cleanedSkeleton = bwareaopen(logical(skeletonization), 20);

end