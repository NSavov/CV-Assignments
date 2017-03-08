sphere1 = imread('sphere1.ppm');
sphere2 = imread('sphere2.ppm');
%sphere1 = imread('pingpong/0001.jpeg');
%sphere2 = imread('pingpong/0002.jpeg');
synth1 = imread('synth1.pgm');
synth2 = imread('synth2.pgm');
window_size = 15;
half_window = floor(window_size/2);
sphere_sizex = size(sphere1, 1);

sphere_sizey = size(sphere1, 2);
synth_sizex = size(synth1, 1);
synth_sizey = size(synth1, 2);
[sphere_Vx, sphere_Vy] = lucas_kanade(rgb2gray(sphere1), rgb2gray(sphere2), window_size);
[sphere_x, sphere_y] = meshgrid(0:window_size:(sphere_sizey-window_size), 0:window_size:(sphere_sizex-window_size));

[synth_Vx, synth_Vy] = lucas_kanade(synth1, synth2, window_size);
[synth_x, synth_y] = meshgrid(0:window_size:(synth_sizey-window_size), 0:window_size:(synth_sizex-window_size));
figure()

subplot(231);
imshow(sphere1);
title('Sphere 1');
subplot(232);
imshow(sphere2);

subplot(233)
imshow(sphere2);
hold on
title('Sphere 2');
sphere_Vx_display = zeros(sphere_sizex,sphere_sizey );
sphere_Vy_display = zeros(sphere_sizex,sphere_sizey );
sphere_Vx_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = sphere_Vx(:,:,:);
sphere_Vy_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = sphere_Vy(:,:,:);
quiver(sphere_Vx_display, sphere_Vy_display, 10);
hold off
set(gca, 'YDir', 'reverse')
title('Optical flow');

subplot(234);
imshow(synth1);
title('Synth 1');

subplot(235);
imshow(synth2);
title('Synth 2');

subplot(236);
imshow(synth2);
hold on
synth_Vx_display = zeros(synth_sizex,synth_sizey );
synth_Vy_display = zeros(synth_sizex,synth_sizey );
synth_Vx_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = synth_Vx(:,:,:);
synth_Vy_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = synth_Vy(:,:,:);
quiver( synth_Vx_display, synth_Vy_display, 10);
set(gca, 'YDir', 'reverse')
hold off
title('Optical flow');