image = imread('pingpong/0001.jpeg');
%7, 300, 3.2, 4
[Ix, Iy, H, r, c] = harris(image, 7, 30, 4, 7);

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
    
