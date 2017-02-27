image = imread('../Images/image4.jpeg');
unsharped = unsharp(image, 1, [5 5], 5);
subplot(221)
imshow(image)
title('original')

subplot(222)
imshow(unsharped)
title('sigma:1 size:5 k:5')

unsharped = unsharp(image, 5, [5 5], 10);
subplot(223)
imshow(unsharped)
title('sigma:5 size:5 k:10')

subplot(224)
unsharped = unsharp(image, 5, [11 11], 10);
imshow(unsharped)
title('sigma:5 size:11 k:10')
suptitle('Unsharp')
