function [sift, RGB_sift, rgb_sift] = extract_features(image, method)
I = single(rgb2gray(image)) ;
if strcmp(method, 'dense')
    [~,sift] = vl_dsift(I) ;
    
    [~, R_sift] = vl_dsift(I(:,:,1));
    [~, G_sift] = vl_dsift(I(:,:,2));
    [~, B_sift] = vl_dsift(I(:,:,3));
elseif strcmp(method, 'keypoint')
    [~,sift] = vl_sift(I) ;
    
    [~, R_sift] = vl_sift(I(:,:,1));
    [~, G_sift] = vl_sift(I(:,:,2));
    [~, B_sift] = vl_sift(I(:,:,3));
end


RGB_sift = cat(3, R_sift, G_sift, B_sift);
end