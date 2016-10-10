
function [enhanced] = ricci4roots(I)

    % initialize a matrix with the size of the image 
    riccis = zeros(size(I, 1), size(I, 2), 6);
    
    % for each of the images, compute Ricci & Perfetti feature
    count = 1;
    for k = 3 : 2 : 15 
        [ricci] = Ricci2007(imcomplement(double(I)), k, k);
        riccis(:,:,count) = ricci(:,:,1);
        count = count + 1;
    end
    
    % image enhanced will be the maximum over different scales
    enhanced = max(riccis, [], 3);

end