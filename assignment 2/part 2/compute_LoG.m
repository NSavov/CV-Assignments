function imOut = compute_LoG(image, LOG_type)
    switch LOG_type
        case 1
            %method 1
            %first apply gaussian which smooths
            %then wit laplace sharpen the general features
            %we got edges!
            blurred = imgaussfilt(image, 0.7);
            h = fspecial('laplacian');
            imOut = imfilter(blurred, h);
            
        case 2
            %method 2
            h = fspecial('log');
            imOut = imfilter(image, h);
            
        case 3
            %method 3
            sigma1 = 1;
            sigma2 = 4;
            imOut = imgaussfilt(image, sigma1) - imgaussfilt(image, sigma2);
    end
end