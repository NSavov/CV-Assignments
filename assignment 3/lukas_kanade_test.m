sphere1 = imread('sphere1.ppm');
sphere2 = imread('sphere2.ppm');
%sphere1 = imread('pingpong/0001.jpeg');
%sphere2 = imread('pingpong/0002.jpeg');
synth1 = imread('synth1.pgm');
synth2 = imread('synth2.pgm');
window_size = 15;
sphere_sizex = size(sphere1, 1);
sphere_sizey = size(sphere1, 2);
synth_sizex = size(synth1, 1);
synth_sizey = size(synth1, 2);
% we need to vertically flip (flipud) the image since it is vertically
% flipped wrt to how the plotting funcitons show it. Plotting functions
% have the origin at bottom left corner (normal in math) but image display
% functions use top left
[sphere_Vx, sphere_Vy] = lucas_kanade(flipud(rgb2gray(sphere1)), flipud(rgb2gray(sphere2)), window_size);
[sphere_x, sphere_y] = meshgrid(0:window_size:(sphere_sizey-window_size), 0:window_size:(sphere_sizex-window_size));

[synth_Vx, synth_Vy] = lucas_kanade(flipud(synth1), flipud(synth2), window_size);
[synth_x, synth_y] = meshgrid(0:window_size:(synth_sizey-window_size), 0:window_size:(synth_sizex-window_size));

subplot(231);
imshow(sphere1);
title('Sphere 1');
subplot(232);
imshow(sphere2);
title('Sphere 2');
subplot(233);
quiver(sphere_x, sphere_y, sphere_Vx, sphere_Vy);
title('Optical flow');
subplot(234);
imshow(synth1);
title('Synth 1');
subplot(235);
imshow(synth2);
title('Synth 2');
subplot(236);
quiver(synth_x, synth_y, synth_Vx, synth_Vy);
title('Optical flow');