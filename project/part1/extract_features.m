function [sift, RGB_sift, rgb_sift, opponent_sift] = extract_features(image, method)
grayscale_image = single(rgb2gray(image)) ;

rgb_image = rgb2normedrgb(image);
opponent_image = rgb2opponent(image);

if strcmp(method, 'dense')
    vl_dsift_set_steps()
    [~,sift] = vl_dsift(grayscale_image,'size', 5) ;
    
    [~, R_sift] = vl_dsift(single(image(:,:,1)));
    [~, G_sift] = vl_dsift(single(image(:,:,2)));
    [~, B_sift] = vl_dsift(single(image(:,:,3)));
    
    [~, r_sift] = vl_dsift(single(rgb_image(:,:,1)));
    [~, g_sift] = vl_dsift(single(rgb_image(:,:,2)));
    [~, b_sift] = vl_dsift(single(rgb_image(:,:,3)));
    
    [~, o1_sift] = vl_dsift(single(opponent_image(:,:,1)));
    [~, o2_sift] = vl_dsift(single(opponent_image(:,:,2)));
    [~, o3_sift] = vl_dsift(single(opponent_image(:,:,3)));
elseif strcmp(method, 'keypoint')
    [~,sift] = vl_sift(grayscale_image) ;
    
    [~, R_sift] = vl_sift(single(image(:,:,1)));
    [~, G_sift] = vl_sift(single(image(:,:,2)));
    [~, B_sift] = vl_sift(single(image(:,:,3)));
    
    [~, r_sift] = vl_sift(single(rgb_image(:,:,1)));
    [~, g_sift] = vl_sift(single(rgb_image(:,:,2)));
    [~, b_sift] = vl_sift(single(rgb_image(:,:,3)));
    
    [~, o1_sift] = vl_sift(single(opponent_image(:,:,1)));
    [~, o2_sift] = vl_sift(single(opponent_image(:,:,2)));
    [~, o3_sift] = vl_sift(single(opponent_image(:,:,3)));
end

RGB_sift = cat(3, R_sift, G_sift, B_sift);
rgb_sift = cat(3, r_sift, g_sift, b_sift);
opponent_sift = cat(3, o1_sift, o2_sift, o3_sift);


end