lena_img = imread('../Images/image1.jpeg');

imshow(lena_img)
title('Original')

figure()

subplot(221)
smooth_lena = uint8(gaussConv(lena_img, 3, 3, 5));
imshow(smooth_lena)
title('Sigma: 3, Size: 5')

subplot(222)
smooth_lena = uint8(gaussConv(lena_img, 8, 8, 5));
imshow(smooth_lena)
title('Sigma: 8, Size: 5')

subplot(223)
smooth_lena = uint8(gaussConv(lena_img, 3, 3, 9));
imshow(smooth_lena)
title('Sigma: 3, Size: 9')

subplot(224)
smooth_lena = uint8(gaussConv(lena_img, 8, 8, 9));
imshow(smooth_lena)
title('Sigma: 8, Size: 9')
suptitle('Gaussian Blur')

figure()
subplot(121)
smooth_lena = uint8(gaussConv(lena_img, 8, 1, 9));
imshow(smooth_lena)
title('SigmaX: 8, SigmaY: 1, Size: 9')
subplot(122)
smooth_lena = uint8(gaussConv(lena_img, 1, 8, 9));
imshow(smooth_lena)
title('SigmaX: 1, SigmaY: 8, Size: 9')
suptitle('Motion Blur')

figure()
subplot(121)
smooth_lena = uint8(gaussConv(lena_img, 3, 3, 5));
imshow(smooth_lena)
title('Our implementation')

subplot(122)
h = fspecial('gaussian', [5 5], 3);
smooth_lena = imfilter( lena_img, h);
imshow(smooth_lena)
title('Matlab')
