image1 = imread('left.jpg');
image2 = imread('right.jpg');
subset_size = 20;

image_alignment(image1, image2, subset_size, 'average_overlap')