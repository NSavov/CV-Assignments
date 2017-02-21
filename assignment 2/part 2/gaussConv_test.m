lena_img = imread('../Images/image1.jpeg');
smooth_lena = uint8(gaussConv(lena_img, 3, 3, 5));
imshow(smooth_lena)
