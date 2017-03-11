function [] = overlay(source, matching, T)
% warpT = affine2d( T);
% transformed = imwarp(matching, warpT, 'nearest'); %,'OutputView', imref2d(size(image2))
% imshow(transformed);

transformed = image_transform(matching, T);
imshow(transformed);

corners = [1 1 1; 1 size(matching, 1) 1 ;size(matching, 2) 1 1; size(matching, 2) size(matching, 1) 1];

new_corners = corners*T;

left_c = min(new_corners(:, 1));
right_c = max(new_corners(:, 1));
top_c = min(new_corners(:, 2));
bottom_c = max(new_corners(:, 2));

translate_x = 0;
if left_c < 1
    translate_x = abs(left_c)+1;
end

if left_c > 1
    translate_x = -left_c+1;
end

translate_y = 0;
if top_c < 1
    translate_y = abs(top_c)+1;
end

if top_c > 1
    translate_y = -top_c+1;
end



hold on
source = imtranslate(source,[translate_x, translate_y],'OutputView','full');
% image1 = padarray(image1,[size(transformed,1) - size(image1,1),size(transformed,2) - size(image1,2)],0,'post');
h = imshow(source);
set(h,'AlphaData', 0.5)
hold off
end