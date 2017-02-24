image = imread('../Images/image2.jpeg');

subplot(221)
denoised = denoise(image, 'box', [3 3]);
imshow(denoised)
title('3x3')


subplot(222)
denoised = denoise(image, 'box', [5 5]);
imshow(denoised)
title('5x5')


subplot(223)
denoised = denoise(image, 'box', [7 7]);
imshow(denoised)
title('7x7')


subplot(224)
denoised = denoise(image, 'box', [9 9]);
imshow(denoised)
title('9x9')

suptitle('Box filtering')

figure()

subplot(221)
denoised = denoise(image, 'median', [3 3]);
imshow(denoised)
title('3x3')


subplot(222)
denoised = denoise(image, 'median', [5 5]);
imshow(denoised)
title('5x5')


subplot(223)
denoised = denoise(image, 'median', [7 7]);
imshow(denoised)
title('7x7')


subplot(224)
imshow(image)
title('Original')

suptitle('Median filtering')
