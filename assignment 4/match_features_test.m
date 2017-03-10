% prepare the images as single precision double matrices
original_img1 = imread('boat1.pgm');
original_img2 = imread('boat2.pgm');
img1 = single(original_img1);
img2 = single(original_img2);

% get all the SIFT gadgets
[matches, scores, f1, f2] = match_features(img1, img2);

figure() ; 
side_view = cat(2, original_img1, original_img2);
imshow(side_view) ;
hold on; % keep the same canvas for the next plot: the feature mapping

% pick 50 random matches
perm = randperm(size(matches,2)) ;
sel = perm(1:50) ;

% pick the 50 randomly sampled feature matches (sel gives us the column
% indexes (identifiers) of the features in f1, and their first row gives
% their first coordinate)
x1 = f1(1,matches(1,sel));
% don't forget to add img1 width to the coordinates of img2 since they're
% shown side by side
x2 = f2(1,matches(2,sel)) + size(img1,2);
y1 = f1(2,matches(1,sel)); % get the second coordinate
y2 = f2(2,matches(2,sel));

h = line([x1 ; x2], [y1 ; y2]); % lines mapping features on both images
set(h,'linewidth', 1, 'color', 'b');

% plot the 50 randomly sampled matched features
vl_plotframe(f1(:,matches(1,sel)));
f2(1,:) = f2(1,:) + size(img1,2);
vl_plotframe(f2(:,matches(2,sel)));
hold off;
axis image off;