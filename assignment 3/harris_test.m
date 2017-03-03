image = imread('pingpong/0001.jpeg');

[Ix, Iy, H, r, c] = harris(image, 7, 300, 3.5, 3);

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
    
    
