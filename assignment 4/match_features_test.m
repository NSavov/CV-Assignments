% prepare the images as single precision double matrices
original_img1 = imread('boat1.pgm');
original_img2 = imread('boat2.pgm');

% get all the SIFT gadgets
[matches, scores, f1, f2] = match_features(original_img1, original_img2);

figure(); 
side_view = cat(2, original_img1, original_img2);
imshow(side_view);
hold on; % keep the same canvas for the next plot: the feature mapping

% pick 50 random matches
perm = randperm(size(matches,2)) ;
sel = perm(1:50) ;

% now we'll plot the blobs in both images matched with lines. We based this
% plotting code on this answer in stackoverflow: 
% http://stackoverflow.com/questions/9529020/how-to-plot-the-matched-points-with-each-other-in-sift-implementation-of-andrea
% pick the 50 randomly sampled feature matches (sel gives us the column
% indexes (identifiers) of the features in f1, and their first row gives
% their first coordinate)
x1 = f1(1,matches(1,sel));
% don't forget to add img1 width to the coordinates of img2 since they're
% shown side by side
x2 = f2(1,matches(2,sel)) + size(original_img1,2);
y1 = f1(2,matches(1,sel)); % get the second coordinate
y2 = f2(2,matches(2,sel)); % no need to add nothing here, heights are same in both images coordinates

% lines mapping features on both images. line takes two matrices, one for x
% coordinates and the other for y. First row for line origin (first image)
% and second row for line end (second image
h = line([x1 ; x2], [y1 ; y2]); % this line will be plotted in the current figure when we call hold off
set(h,'linewidth', 1, 'color', 'b');

% plot the 50 randomly sampled matched features. vl_plotfram will print
% nice blobs representing feature location, scale and orientation
vl_plotframe(f1(:,matches(1,sel)));
% before plotting features in our second image, add the width of first
% image to their x coordinate
f2(1,:) = f2(1,:) + size(original_img1,2);
vl_plotframe(f2(:,matches(2,sel)));
hold off; % now kiss!
axis image off;