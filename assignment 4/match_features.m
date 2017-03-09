original_img1 = imread('boat1.pgm');
original_img2 = imread('boat2.pgm');

img1 = single(original_img1) ;

[f1,d1] = vl_sift(img1) ;
figure()
imshow(original_img1);

perm = randperm(size(f1,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f1(:,sel)) ;
h2 = vl_plotframe(f1(:,sel)) ;
set(h1,'color','k','linewidth',3) ; %draw black borders
set(h2,'color','y','linewidth',2) ; %set yellow as the solid color


figure() ; 

side_view = cat(2, original_img1, original_img2);
imshow(side_view) ;

img2 = single(original_img2) ;
[f2,d2] = vl_sift(img2) ;

[matches, scores] = vl_ubcmatch(d1, d2) ;

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


