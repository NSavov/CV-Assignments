function [sift] = extract_sift(image, method, sift_type, sample_size)

if strcmp(sift_type, 'opponent')
    image = rgb2opponent(image);
end

if strcmp(sift_type, 'rgb')
    image = rgb2normedrgb(image);
end

grayscale_image = single(rgb2gray(image));

if strcmp(method, 'dense')
    if strcmp(sift_type, 'grayscale')
        [~,sift] = vl_dsift(grayscale_image, 'step', sample_size);
    else
        [f,~] = vl_dsift(grayscale_image, 'step', sample_size) ;%vl_phow(grayscale_image, 'step', sample_size);
        f(3,:) = 1 ;
        f(4,:) = 0 ;
        [~, R_sift] = vl_sift(single(image(:,:,1)), 'frames', f);
        [~, G_sift] = vl_sift(single(image(:,:,2)), 'frames', f);
        [~, B_sift] = vl_sift(single(image(:,:,3)), 'frames', f);
        
        sift = cat(1, R_sift, G_sift, B_sift);
        
    end
    
elseif strcmp(method, 'keypoint')
    if strcmp(sift_type, 'grayscale')
        [~,sift] = vl_sift(grayscale_image) ;
    else
        [f,~] = vl_sift(grayscale_image) ;
        
        [~, R_sift] = vl_sift(single(image(:,:,1)), 'frames', f);
        [~, G_sift] = vl_sift(single(image(:,:,2)), 'frames', f);
        [~, B_sift] = vl_sift(single(image(:,:,3)), 'frames', f);
        
        sift = cat(1, R_sift, G_sift, B_sift);
%         
%         [R_f, ~] = vl_sift(single(image(:,:,1)));
%         [G_f, ~] = vl_sift(single(image(:,:,2)));
%         [B_f, ~] = vl_sift(single(image(:,:,3)));    
% 
%         u = cat(1, R_f', G_f', B_f');
% 
%         [~, R_sift] = vl_sift(single(image(:,:,1)), 'frames', u');
%         [~, G_sift] = vl_sift(single(image(:,:,2)), 'frames', u');
%         [~, B_sift] = vl_sift(single(image(:,:,3)), 'frames', u');
% 
%         sift = cat(1, R_sift, G_sift, B_sift);
    end
end



size(sift)
end