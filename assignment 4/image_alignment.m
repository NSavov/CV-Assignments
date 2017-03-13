% uncomment for boat images
% image2 = imread('boat1.pgm');
% image1 = imread('boat2.pgm');
% subset_size = 20;

% source = image1;
% matching = image2;

image1 = imread('left.jpg');
image2 = imread('right.jpg');
subset_size = 20;

% ransac doesn't care that the right image has extra stuff that the left
% image doesn't. vl_feat will find common features that ransac can try to
% match anyway. Ransac won't try to match every pixel in the image, only
% some of those that vl_feat found to be good matches
T = ransac(image1, image2, 100, subset_size);

stitched = image_stitching(image1, image2, T, 'average_overlap');

imshow(stitched);
imwrite(stitched, 'stitched.jpeg')