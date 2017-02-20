function imOut = denoise(image, kernel_type, kernel_size)
    if strcmp(kernel_type, 'box')
        imOut = imboxfilt(image, kernel_size);
    end
    
    if strcmp(kernel_type, 'median')
        imOut = medfilt2(image, kernel_size);
    end

end
% 
% function imOut = denoise(image, kernel_type, kernel_size)
%     k_rows = kernel_size(1);
%     k_cols = kernel_size(2);
%     rows = size(image, 1);
%     cols = size(image, 2);
%     imOut = zeros(rows, cols);
%     for rowInd = (k_rows-1)/2:(rows-(k_rows-1)/2)
%         for colInd = (k_cols-1)/2:(cols-(k_cols-1)/2)
%             subM = image(rowInd - (k_rows-1)/2, colInd - (k_cols-1)/2);
%             if kernel_type = 'box'
%                 
%             end
%         end
%     end
% end
%     
% function imOut = denoise(image, kernel_type, kernel_size)
%     
% end