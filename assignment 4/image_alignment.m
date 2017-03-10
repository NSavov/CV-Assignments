
image1 = imread('boat1.pgm');
image2 = imread('boat2.pgm');
T = ransac(image1, image2, 100, 50);

% transformed = image2*T;
% meshgrid()


warpT = affine2d( T);
transformed = imwarp(image2, warpT, 'nearest'); %,'OutputView', imref2d(size(image2))
imshow(transformed);
hold on
% image1 = imtranslate(image1,[108, 160],'OutputView','full');
% h = imshow(image1);
% set(h,'AlphaData', 0.5)
hold off