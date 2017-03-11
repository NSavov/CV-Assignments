function [] = overlay(source, matching, T)
% warpT = affine2d( T);
% transformed = imwarp(matching, warpT, 'nearest'); %,'OutputView', imref2d(size(image2))
% imshow(transformed);

transformed = image_transform(matching, T);
imshow(transformed);

corners = [1 1 1; 1 size(matching, 1) 1 ;size(matching, 2) 1 1; size(matching, 2) size(matching, 1) 1];

new_corners = corners*T;

[~, left_ind] = min(new_corners(:, 1));
[~, right_ind] = max(new_corners(:, 1));
[~, top_ind] = min(new_corners(:, 2));
[~, bottom_ind] = max(new_corners(:, 2));

translate_x = 0;
if new_corners(left_ind, 1) < 1
    translate_x = abs(new_corners(left_ind, 1))+1;
end
translate_y = 0;
if new_corners(top_ind, 2) < 1
%     new_corners(top_ind, 2)
    translate_y = abs(new_corners(top_ind, 2))+1;
end

hold on
source = imtranslate(source,[translate_x, translate_y],'OutputView','full');
% image1 = padarray(image1,[size(transformed,1) - size(image1,1),size(transformed,2) - size(image1,2)],0,'post');
h = imshow(source);
set(h,'AlphaData', 0.5)
hold off
end