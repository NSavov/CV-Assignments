function imOut = denoise(image, kernel_type, kernel_size)
% DENOISE removes the noise from a given input image by applying either a median or box
% filtering of given kernel size
%   image: input image as a greyscale matrix of uint8 intensities
%   kernel_type: string, either 'median' or 'box'
%   kernel_size: integer with the kernel size as a 1x2 array [rows cols]. 
%   Both rows and cols must be odd numbers so the kernel has a center
%   imOut: the denoised image
    k_rows = kernel_size(1);
    k_cols = kernel_size(2);
    image = padarray(image, [(k_cols-1)/2, (k_rows-1)/2]);
    rows = size(image, 1);
    cols = size(image, 2);
    imOut = zeros([rows, cols], 'uint8');
    r_dist = (k_rows-1)/2; % x coordinate of the kernel center
    c_dist = (k_cols-1)/2; % y coordinate of the kernel center
    for rowInd = r_dist+1:(rows-r_dist) % pixel by pixel, always the one at the kernel center
        for colInd = c_dist+1:(cols-c_dist)
            % build the subimage under the kernel
            subM = image((rowInd - r_dist):(rowInd + r_dist), (colInd - c_dist):(colInd + c_dist));
            if strcmp(kernel_type, 'box')
                imOut(rowInd, colInd) = box_filter(subM); % apply the appropriate filter
            end
            
            if strcmp(kernel_type , 'median')
                imOut(rowInd, colInd) = median_filter(subM);
            end
        end
    end
    
    imOut = imOut(((k_rows-1)/2):(size(imOut, 1)- ((k_rows-1)/2)), ((k_cols-1)/2):(size(imOut, 2)- ((k_cols-1)/2)));
    
end
    
function filterOut = box_filter(subM)
% BOX_FILTER applies a box filter (i. e. average of the element-wise
% multiplication between the image and a same size matrix full of ones) to
% a given image
%   subM: image to filter on. Normally, a small piece of a bigger image.
%   Both its dimensions must be odd
%   filterOut: new value of the center pixel of subM, after applying the
%   box filter
    filterOut = mean(subM(:)); 
end

function filterOut = median_filter(subM)
% MEDIAN_FILTER applies a median filter (i. e. median of the element-wise
% multiplication between the image and a same size matrix full of ones) to
% a given image
%   subM: image to filter on. Normally, a small piece of a bigger image.
%   Both its dimensions must be odd
%   filterOut: new value of the center pixel of subM, after applying the
%   median filter
    filterOut = median(subM(:));
end