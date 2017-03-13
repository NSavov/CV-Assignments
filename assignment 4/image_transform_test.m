original_img1 = imread('boat1.pgm');

figure();
subplot(131);
imshow(original_img1);
title('Original image');
% just a 45 degrees rotation plus 100,50 traslation matrix
T = [cos(pi/4) -sin(pi/4) 0; sin(pi/4) cos(pi/4) 0; 100 50 1];
transformed_img = image_transform(original_img1, T);
subplot(132);
imshow(transformed_img);
title('Our implementation');
subplot(133);
warpT = affine2d( T);
transformed = imwarp(original_img1, warpT, 'nearest'); %,'OutputView', imref2d(size(image2))
imshow(transformed);
title('imwarp');