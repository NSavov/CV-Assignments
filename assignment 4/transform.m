% just a 45 degrees rotation plus 100,50 traslation matrix
T = [cos(pi/4) -sin(pi/4) 0; sin(pi/4) cos(pi/4) 0; 100 50 1];
% T_nice = affine2d(T);
% original_img1 = imread('boat1.pgm');
% new_img1 = imwarp(original_img1, T_nice);
% imshow(new_img1);
im_test = zeros(10,10) + 0.5;
im_test(5,:) = ones(1,10);
figure();
subplot(121);
imshow(im_test,[]);
title('original');

[original_h original_w] = size(im_test);

%corners = [0 0; original_h-1 0; 0 original_w-1; original_h-1 original_w-1];
corners = [1 1; original_h 1; 1 original_w; original_h original_w];

newcorners = [corners(1,:)*T(1:2,1:2); corners(2,:)*T(1:2,1:2); corners(3,:)*T(1:2,1:2); corners(4,:)*T(1:2,1:2)];
min_h = min(newcorners(:,1));% horizontal traslation factor for everybody
offset_h = 0;
if min_h < 1
    offset_h = 1 + abs(min_h); 
end
min_w = min(newcorners(:,2));% vertical traslation factor for everybody
offset_w = 0;
if min_w < 1
   offset_w = 1 + abs(min_w); 
end
new_h = ceil(max(newcorners(:,1)) + offset_h);
new_w = ceil(max(newcorners(:,2)) + offset_w);
new_img = zeros(new_h, new_w);
curated_newcorners = floor(newcorners) + [offset_h offset_w]
onset_newcorners = curated_newcorners - [offset_h offset_w]
inversed_transformed_newcorners = round(onset_newcorners*T(1:2,1:2)')
for y = 1:new_w
   for x = 1:new_h
       mapped_coords = [x-offset_h y-offset_w]*T(1:2,1:2)';
       mapped_coords = round(mapped_coords);
       if mapped_coords(1) >= 1 && mapped_coords(1) <= original_h && mapped_coords(2) >= 1 && mapped_coords(2) <= original_w
        new_img(x, y) = im_test(mapped_coords(1), mapped_coords(2));
       end
   end
end
subplot(122);
imshow(new_img);
title('transformed');


