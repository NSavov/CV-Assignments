image = imread('person_toy/00000001.jpg');
%7, 300, 3.2, 4
[Ix, Iy, H, r, c] = harris(image, 7, 1000, 2, 2);

%plots
subplot(221)
imshow(Ix,[])

subplot(222)
imshow(Iy,[])

subplot(223)
imshow(H, [])

subplot(224)
imshow(image,[])
hold on
scatter(c, r, 'r.')
hold off
max(max(H))
    
