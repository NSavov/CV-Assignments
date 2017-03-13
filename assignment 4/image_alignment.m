
% image1 = imread('boat1.pgm');
% image2 = imread('boat2.pgm');

image1 = imread('left.jpg');
image2 = imread('right.jpg');

source = rgb2gray(image1);
matching = rgb2gray(image2);

T = ransac(source, matching, 100, 20);

% T = ransac(source, matching, 100, 50);

image_stitching(image1, image2, T, 'average_overlap')