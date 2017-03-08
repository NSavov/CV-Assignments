image = imread('person_toy/00000001.jpg');
%7, 300, 3.2, 4
% image = imgaussfilt(image, 1.5);
% [Ix, Iy, H, r, c] = harris(image , 25, 30, 3, 1.6);

image = imgaussfilt(image, 1.5);
[Ix, Iy, H, r, c] = harris(image , 25, 30, 3, 1.6);

%plots
subplot(221)
imshow(Ix,[])

subplot(222)
imshow(Iy,[])

subplot(223)
imshow(H, [])

subplot(224)
%figure()
imshow(image,[])
hold on
scatter(c, r, 'r.')
hold off
    
