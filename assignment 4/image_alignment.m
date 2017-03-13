image1 = imread('left.jpg');
image2 = imread('right.jpg');

source = rgb2gray(image1);
matching = rgb2gray(image2);

%T = ransac(source, matching, 100, 20);

% ransac doesn't care that the right image has extra stuff that the left
% image doesn't. vl_feat will find common features that ransac can try to
% match anyway. Ransac won't try to match every pixel in the image, only
% some of those that vl_feat found to be good matches
T = ransac(matching, source, 100, 20);

%image_stitching(image1, image2, T, 'average_overlap')
image_stitching(image2, image1, T, 'average_overlap')