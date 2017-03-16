function [sift] = extract_sift_grayscale(image, method)
grayscale_image = single(rgb2gray(image)) ;

if strcmp(method, 'dense')
    [~,sift] = vl_dsift(grayscale_image) ;
    
elseif strcmp(method, 'keypoint')
    [~,sift] = vl_sift(grayscale_image) ;
end

end