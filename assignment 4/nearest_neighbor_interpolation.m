% original_img1 = imread('boat1.pgm');
% original_img1(40, 40) = 0;
% original_img1(42, 40) = 0;
% original_img1(44, 40) = 0;
% original_img1(40, 43) = 0;
%imshow(original_img1);
figure();
subplot(131);
I = checkerboard(20, 3, 4);
[old_H, old_W] = size(I);
imshow(I);
title('original');

new_H = 300; new_W = 300;
h_ratio = new_H/old_H;
w_ratio = new_W/old_W;

output = zeros(new_H, new_W) + 0.5;
for h = 0:new_H -1
   for w = 0:new_W -1
       output(h+1, w+1) = I(1 + floor(h/h_ratio), 1+ floor(w/w_ratio));
   end
end
subplot(132);
imshow(output);
title('with nearest neighbor interpolation');

output_bad = zeros(new_H, new_W) + 0.5;
for h = 0:old_H - 1
   for w = 0:old_W -1
       output_bad(1+floor(h*h_ratio), 1+floor(w*w_ratio)) = I(1 + h, 1 + w);
   end
end
subplot(133);
imshow(output_bad);
title('without interpolation');