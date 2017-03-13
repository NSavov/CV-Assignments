% uncomment for boat images
% image2 = imread('boat1.pgm');
% image1 = imread('boat2.pgm');
% subset_size = 20;

% imshow(image2)

% source = image1;
% matching = image2;

image1 = imread('left.jpg');
image2 = imread('right.jpg');
subset_size = 50;

source_gray = image1;
if size(image1,3) > 1
    source_gray = rgb2gray(image1);
end

matching_gray = image2;
if size(image2,3) > 1
    matching_gray = rgb2gray(image2);
end

T = ransac(source_gray, matching_gray, 100, 20);

image_stitching(image1, image2, T, 'average_overlap')