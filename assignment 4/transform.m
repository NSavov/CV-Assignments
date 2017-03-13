% just a 45 degrees rotation plus 100,50 traslation matrix
T = [cos(pi/4) -sin(pi/4) 0; sin(pi/4) cos(pi/4) 0; 100 50 1];
% T_nice = affine2d(T);
% original_img1 = imread('boat1.pgm');
% new_img1 = imwarp(original_img1, T_nice);
% imshow(new_img1);
im_test = zeros(10,10);
im_test(5,:) = ones(1,10);
figure();
subplot(121);
imshow(im_test,[]);
title('original');

[original_h original_w] = size(im_test);

%corners = [0 0; original_h-1 0; 0 original_w-1; original_h-1 original_w-1];
corners = [1 1; original_h 1; 1 original_w; original_h original_w];

newcorners = [corners(1,:)*T(1:2,1:2); corners(2,:)*T(1:2,1:2); corners(3,:)*T(1:2,1:2); corners(4,:)*T(1:2,1:2)];
min_h = floor(min(newcorners(:,1)));% horizontal traslation factor for everybody
if min_h > 0
    min_h = 0;
end
min_w = floor(min(newcorners(:,2)));% vertical traslation factor for everybody
if min_w > 0
   min_w = 0; 
end
newcorners
newcorners(:,1) = newcorners(:,1) + abs(min_h) + 1;
newcorners(:,2) = newcorners(:,2) + abs(min_w) + 1;
new_h = max(floor(newcorners(:,1))) 
new_w = max(floor(newcorners(:,2)))
new_img = zeros(new_h, new_w)
newcorners
for y = 0:new_w-1
   for x = 0:new_h-1
       y
       x
       mapped_coords = T(1:2,1:2)'*[x; y]
       mapped_coords = mapped_coords + [abs(min_h) + 1; abs(min_w) + 1]
       mapped_coords = floor(mapped_coords);
       new_img(x+1, y+1) = im_test(mapped_coords(1), mapped_coords(2))
   end
end


