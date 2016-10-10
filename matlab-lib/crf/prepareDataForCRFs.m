
function [U, P, theta_x] = prepareDataForCRFs(I, w_u)

    % encode unary potentials
    U = zeros(size(I, 1), size(I, 2), 2);
    U(:,:,1) = I * w_u;
    U(:,:,2) = imcomplement(I * w_u);
    
    % encode pairwise potentials
    P = I;

    % estimate theta_x
    maxNumberPairwises = (size(P,1) * size(P,2));
    numMedians = 10;
    if (numMedians * 10000) > maxNumberPairwises
        numMedians = floor(maxNumberPairwises / 10000);
        if numMedians == 0
            theta_x = abs((median(pdist(P(:)))));
        else
            medians = zeros(numMedians,1);
            for k = 1 : numMedians
                medians(k) = abs((median(pdist(randsample(P(:), 10000)))));
            end
            theta_x = median(medians);
        end
    else
        medians = zeros(numMedians,1);
        for k = 1 : numMedians
            medians(k) = abs((median(pdist(randsample(P(:), 10000)))));
        end
        theta_x = median(medians);
    end
    
    % divide image by the estimated theta_x
    P = P / theta_x;

end