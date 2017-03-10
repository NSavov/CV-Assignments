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

perm = randperm(size(matches,2)) ;
sel = perm(1:50) ;

x1 = f1(1,matches(1,sel)) ;
x2 = f2(1,matches(2,sel)) + size(img1,2) ;
y1 = f1(2,matches(1,sel)) ;
y2 = f2(2,matches(2,sel)) ;

hold on ;
h = line([x1 ; x2], [y1 ; y2]) ;
set(h,'linewidth', 1, 'color', 'b') ;


vl_plotframe(f1(:,matches(1,sel))) ;
f2(1,:) = f2(1,:) + size(img1,2) ;
vl_plotframe(f2(:,matches(2,sel))) ;
axis image off ;