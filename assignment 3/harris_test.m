image = imread('image3.jpeg');
%image =rgb2gray(image);
[H, r, c] = harris(image, 3, 1000, 3, 2);
    


%imshow(H, [])