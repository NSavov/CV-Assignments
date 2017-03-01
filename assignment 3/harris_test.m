image = imread('pingpong/0000.jpeg');

[H, r, c] = harris(image, 3, 1000, 2, 1);
    
