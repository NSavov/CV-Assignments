% function imOut = denoise(image, kernel_type, kernel_size)
%     if strcmp(kernel_type, 'box')
%         imOut = imboxfilt(image, kernel_size);
%     end
%     
%     if strcmp(kernel_type, 'median')
%         imOut = medfilt2(image, kernel_size);
%     end
% 
% end

function imOut = denoise(image, kernel_type, kernel_size)
    k_rows = kernel_size(1);
    k_cols = kernel_size(2);
    rows = size(image, 1);
    cols = size(image, 2);
    imOut = zeros([rows, cols], 'uint8');
    r_dist = (k_rows-1)/2;
    c_dist = (k_cols-1)/2;
    for rowInd = r_dist+1:(rows-r_dist)
        for colInd = c_dist+1:(cols-c_dist)
            subM = image((rowInd - r_dist):(rowInd + r_dist), (colInd - c_dist):(colInd + c_dist));
            if strcmp(kernel_type, 'box')
                imOut(rowInd, colInd) = box_filter(subM);
            end
            
            if strcmp(kernel_type , 'median')
                imOut(rowInd, colInd) = median_filter(subM);
            end
        end
    end
    
    imshow(imOut)
end
    
function filterOut = box_filter(subM)
    filterOut = mean(subM(:));
end

function filterOut = median_filter(subM)
    filterOut = median(subM(:));
end