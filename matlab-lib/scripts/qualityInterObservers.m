imageName = 'SKMBT_C36414021715140_00';
firstImage = 14;
lastImage = 27;

%groundtruthmasks = cell(lastImage - firstImage);
%skeletonizations = cell(lastImage - firstImage);

qualities = zeros(3, lastImage - firstImage);

for i = firstImage : lastImage
    
    %leo la m�scara del gtruth
    Igt = imread(strcat(root, imageName, num2str(i), '_gtmask', '.png'));
    IsecondObserver = imread(strcat(root, imageName, num2str(i), '_gtmask1', '.png'));

    %figure, imshow(Igt);
    %title('Igt');
    for j = 1:3
        
        %leo la m�scara del sector de la ra�z a evaluar
        mask = imread(strcat(root, imageName, num2str(i), '_mask',num2str(j), '.png'));
%         figure, imshow(mask);
%         title('mask');
        [i_min, i_max, j_min, j_max] = getBoundingBox(mask);
        
        %cropeo el pedazo de imagen que me interesa
        croppedGt = Igt(i_min : i_max, j_min : j_max);
%         figure, imshow(cropped);
%         title('Cropped');
        %leo la esqueletizaci�n
        
        croppedSecondObserver = IsecondObserver(i_min : i_max, j_min : j_max);
        skeletonization = bwmorph(croppedSecondObserver, 'skel', 8);

        
%         figure, imshow(Iskel);
%         title('Iskel');
        %calculo la intersecci�n entre la esqueletizaci�n y el ground truth
%         
        i
        sizeIntersec
        intersec = skeletonization .* croppedGt;
        %cuento en cu�ntos pixeles coinciden
        sizeIntersec = sum(intersec(:));
        %calculo |esqueletizaci�n|
        sizeRoot = sum(skeletonization(:));
        %calculo el hit ratio
        qualities(j,i - firstImage + 1) = sizeIntersec / sizeRoot;
    end
    
end
qualities = qualities';



