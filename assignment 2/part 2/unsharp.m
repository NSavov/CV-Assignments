function imOut = unsharp ( image , sigma , kernel_size , k )
% UNSHARP unsharps a greyscale image by subtracting a gaussian-smoothed 
% version of it, increasing this high-passed version intensity a given
% number of times and adding it to the original image
%   image: original image
%   sigma: variance of the gaussian kernel
%   kernel_size: 2 dimensional array with the hight and width of the
%   gaussian kernel. Both dimensions must be odd
%   k: intensity increase factor of the high passed image
    gaussian = imgaussfilt(image, sigma, 'FilterSize', kernel_size);
    high_pass = image - gaussian;
    imOut = k*high_pass + image;
end