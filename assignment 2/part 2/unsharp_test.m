image = imread('../Images/image4.jpeg');
unsharped = unsharp(image, 1, [5 5], 1);
subplot(221)
imshow(image)
title('original')

subplot(222)
imshow(unsharped)
title('unsharp')

unsharped = unsharp(image, 1, [5 5], 10);
subplot(223)
imshow(unsharped)
title('k=10')

subplot(224)
unsharped = unsharp(image, 1, [11 11], 10);
imshow(unsharped)
title('size:11')
suptitle('Unsharp')
