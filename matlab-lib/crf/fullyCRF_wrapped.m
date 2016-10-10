
function y = fullyCRF_wrapped(unaryPotentials, pairwiseFeatures, weights, thetaPosition)
    
    % Permute dimensions of the unary potentials
    %unaryPotentials = permute(unaryPotentials,[3 2 1]);
    %pairwiseFeatures = permute(pairwiseFeatures, [2 1 3]);

%     % Get the segmentation
%     y = fullyCRFwithGivenPairwises(int32(size(unaryPotentials, 1)), int32(size(pairwisePotentials, 2)), ...
%         single(unaryPotentials), single(pairwiseFeatures), ...
%         single(weights), single(2*thetaPosition^2));
%     
%     % Remove fake detections outside the field of view
%     y = double(y);

    % Get the segmentation
    y = fullyCRF(int32(size(unaryPotentials, 1)), int32(size(unaryPotentials, 2)), ...
        single(unaryPotentials), single(pairwiseFeatures), ...
        single(weights), single(thetaPosition));
    
    % Remove fake detections outside the field of view
    y = double(y);

end