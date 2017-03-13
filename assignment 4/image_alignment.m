
image1 = imread('boat1.pgm');
image2 = imread('boat2.pgm');

source = image1;
matching = image2;

T = ransac(source, matching, 100, 50);

% transformed = image2*T;
% meshgrid()


warpT = affine2d( T);
transformed = imwarp(matching, warpT, 'nearest'); %,'OutputView', imref2d(size(image2))
imshow(transformed);

corners = [0 0 1; 0 size(matching, 1)-1 1 ;size(matching, 2)-1 0 1; size(matching, 2)-1 size(matching, 1)-1 1];

new_corners = corners*T;
% new_corners
% new_corners

[~, left_ind] = min(new_corners(:, 1));
[~, right_ind] = max(new_corners(:, 1));
[~, top_ind] = min(new_corners(:, 2));
[~, bottom_ind] = max(new_corners(:, 2));
% left_ind

translate_x = 0;
if new_corners(left_ind, 1) < 0
%     new_corners(left_ind, 1)
    translate_x = abs(new_corners(left_ind, 1));
end
translate_y = 0;
if new_corners(top_ind, 2) < 0
%     new_corners(top_ind, 2)
    translate_y = abs(new_corners(top_ind, 2));
end

hold on
image1 = imtranslate(image1,[translate_x, translate_y],'OutputView','full');
% image1 = padarray(image1,[size(transformed,1) - size(image1,1),size(transformed,2) - size(image1,2)],0,'post');
h = imshow(image1);
set(h,'AlphaData', 0.5)
hold off