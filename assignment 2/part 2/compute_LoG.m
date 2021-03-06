function imOut = compute_LoG(image, LOG_type)
% COMPUTE_LOG calculates the LoG (Laplacian convolved Gaussian) of a given
% greyscale image with a given method out of 3 options
%   image: image
%   LOG_type: integer specifying the type of LoG to apply. Can be either of
%   1 (which gets a gaussian-smoothed version of the image with sigma = 0.7
%   and then applies a laplacian filter), 2 (to apply the log operator
%   directly) or 3 to take the difference of a gaussian filter with sigma
%   = 1 and another gaussian filter with sigma = 4
%   imOut: the LoG filtered image
    image = im2double(image);
    switch LOG_type
        case 1
            %method 1
            %first apply gaussian which smooths
            %then wit laplace sharpen the general features
            %we got edges!
            g = fspecial('gaussian', [5 5], 0.5);
            
            h = fspecial('laplacian');
            smooth = imfilter(image, g);
            imOut = imfilter(smooth, h);
            
        case 2
            %method 2
            h = fspecial('log', [5 5], 0.5);
            imOut = imfilter(image, h);
            
        case 3
            %method 3
            sigma1 = 1.2;
            sigma2 = 0.75;
            imOut = imgaussfilt(image, sigma1) - imgaussfilt(image, sigma2);
            
    end
end