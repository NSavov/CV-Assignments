image = imread('../Images/image4.jpeg');
unsharped = unsharp(image, 1, [3 3], 10);
subplot(121)
title('original')
imshow(image)

subplot(122)
title('unsharp')
imshow(unsharped)
