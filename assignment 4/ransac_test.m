
image2 = imread('boat1.pgm');
image1 = imread('boat2.pgm');
subset_size = 50;
image_alignment(image1, image2, subset_size, 'average')

figure()
image2 = imread('boat2.pgm');
image1 = imread('boat1.pgm');
subset_size = 50;
image_alignment(image1, image2, subset_size, 'average')