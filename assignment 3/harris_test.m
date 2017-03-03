image = imread('pingpong/0000.jpeg');

[Ix, Iy, H, r, c] = harris(image, 3, 1000, 2, 1);

%plots
subplot(131)
imshow(Ix,[])

subplot(132)
imshow(Iy,[])

subplot(133)
imshow(H, [])

subplot(133)
imshow(image,[])
hold on
scatter(c, r, 'r.')
hold off
    
    
