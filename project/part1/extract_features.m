function [sift, RGB_sift, rgb_sift] = extract_features(image, method)
grayscale_image = single(rgb2gray(image)) ;

rgb_image = rgb2normedrgb(image);

if strcmp(method, 'dense')
    [~,sift] = vl_dsift(grayscale_image) ;
    
    [~, R_sift] = vl_dsift(single(image(:,:,1)));
    [~, G_sift] = vl_dsift(single(image(:,:,2)));
    [~, B_sift] = vl_dsift(single(image(:,:,3)));
    
    
    [~, r_sift] = vl_dsift(single(rgb_image(:,:,1)));
    [~, g_sift] = vl_dsift(single(rgb_image(:,:,2)));
    [~, b_sift] = vl_dsift(single(rgb_image(:,:,3)));
elseif strcmp(method, 'keypoint')
    [~,sift] = vl_sift(grayscale_image) ;
    

    [~, R_sift] = vl_sift(single(image(:,:,1)));
    [~, G_sift] = vl_sift(single(image(:,:,2)));
    [~, B_sift] = vl_sift(single(image(:,:,3)));
    
    [~, r_sift] = vl_sift(single(rgb_image(:,:,1)));
    [~, g_sift] = vl_sift(single(rgb_image(:,:,2)));
    [~, b_sift] = vl_sift(single(rgb_image(:,:,3)));
end

RGB_sift = cat(3, R_sift, G_sift, B_sift);
rgb_sift = cat(3, r_sift, g_sift, b_sift);
end