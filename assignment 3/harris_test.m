image = imread('person_toy/00000001.jpg');
%7, 300, 3.2, 4
% image = imgaussfilt(image, 1.5);
% [Ix, Iy, H, r, c] = harris(image , 25, 5, 3, 1.6, 10);

[Ix, Iy, H, r, c] = harris(image , 1.4, 3, 5, 3, 2, 15);

%plots
subplot(221)
imshow(Ix,[])
title('X Derivative')

subplot(222)
imshow(Iy,[])
title('Y Derivative')

subplot(223)
imshow(H, [])
title('Cornerness Values')

subplot(224)

imshow(image,[])
hold on
scatter(c, r, 'r.')
hold off
title('Detected Corners')
    
