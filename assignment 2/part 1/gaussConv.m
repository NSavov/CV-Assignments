function imOut = gaussConv ( image , sigma_x , sigma_y , kernel_size )
    H1 = gauss(sigma_x, kernel_size);
    H2 = gauss(sigma_y, kernel_size);
    %imOut = imfilter(image, H1);
    %G = gauss2(3, 5);
    %imOut = conv2(G, image);
    imOut = conv2(H1, H2, image);
end