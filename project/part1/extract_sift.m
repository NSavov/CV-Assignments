function [sift] = extract_sift(image, method, sift_type, sample_size)

if strcmp(sift_type, 'opponent')
    image = rgb2opponent(image);
end

if strcmp(sift_type, 'rgb')
    image = rgb2normedrgb(image);
end

if strcmp(sift_type, 'grayscale')
    image = single(rgb2gray(image));
end

if strcmp(method, 'dense')
    if strcmp(sift_type, 'grayscale')
        [~,sift] = vl_dsift(grayscale_image) ;
    else
        [R_f, R_sift] = vl_dsift(single(image(:,:,1)));
        [G_f, G_sift] = vl_dsift(single(image(:,:,2)));
        [B_f, B_sift] = vl_dsift(single(image(:,:,3)));
        
        %put sampling here
        
        sift = cat(2, R_sift', G_sift', B_sift');	
    end
    
elseif strcmp(method, 'keypoint')
    if strcmp(sift_type, 'grayscale')
        [~,sift] = vl_sift(grayscale_image) ;
    else
        [R_f, R_sift] = vl_sift(single(image(:,:,1)));
        [G_f, G_sift] = vl_sift(single(image(:,:,2)));
        [B_f, B_sift] = vl_sift(single(image(:,:,3)));    

        u = unique(cat(1, R_f', G_f', B_f'), 'rows')';

        [~, R_sift] = vl_sift(single(image(:,:,1)), 'frames', u);
        [~, G_sift] = vl_sift(single(image(:,:,2)), 'frames', u);
        [~, B_sift] = vl_sift(single(image(:,:,3)), 'frames', u);
        
        sift = cat(2, R_sift', G_sift', B_sift');	
    end
end



size(sift)
end