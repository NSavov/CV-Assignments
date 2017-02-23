function imOut = unsharp ( image , sigma , kernel_size , k )
    gaussian = imgaussfilt(image, sigma, 'FilterSize', kernel_size);
    high_pass = image - gaussian;
    imOut = k*high_pass + image;
end