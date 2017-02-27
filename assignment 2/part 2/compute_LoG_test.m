lena = imread('../Images/image1.jpeg');
subplot(131)
% the [] parameter is a range specifying the black and white reference to
% display the image. When the range is empty, then black and white will be
% min(image(:)) and max(image(:)) respectively, so you can think of this as
% a normalization
imshow(compute_LoG(lena, 1), [])
title('Method 1')
subplot(132)
imshow(compute_LoG(lena, 2), [])
title('Method 2')
subplot(133)
imshow(compute_LoG(lena, 3), [])
title('Method 3')
