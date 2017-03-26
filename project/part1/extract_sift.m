function [sift] = extract_sift(image, method, sift_type, sample_size)
%used to extract SIFT feature from an image

%convert to the appropriate color space based on sift_type
if strcmp(sift_type, 'opponent')
    image = rgb2opponent(image);
end

if strcmp(sift_type, 'norm_rgb')
    image = rgb2normedrgb(image);
end

%retrieve a grayscale image used in all SIFT types
grayscale_image = im2single(rgb2gray(image));

if strcmp(method, 'dense')
    if strcmp(sift_type, 'grayscale')
        %retrieve dense grayscale SIFT features directly and use sampling
        %with sample_size
        [~,sift] = vl_dsift(grayscale_image, 'step', sample_size);
    else
        %retrieve dense grayscale SIFT features using sampling
        %with sample_size
        [f,~] = vl_dsift(grayscale_image, 'step', sample_size) ;%vl_phow(grayscale_image, 'step', sample_size);
        
        %set the magnitude and rotation of the features
        f(3,:) = 1 ;
        f(4,:) = 0 ;
        
        %find the features at the positions of the grayscale features
        [~, R_sift] = vl_sift(im2single(image(:,:,1)), 'frames', f);
        [~, G_sift] = vl_sift(im2single(image(:,:,2)), 'frames', f);
        [~, B_sift] = vl_sift(im2single(image(:,:,3)), 'frames', f);
        
        %construct dense colorSift (channels based on the sift type)
        sift = cat(1, R_sift, G_sift, B_sift);
        
    end
    
elseif strcmp(method, 'keypoint')
    if strcmp(sift_type, 'grayscale')
        %retrieve dense grayscale SIFT features directly
        [~,sift] = vl_sift(grayscale_image) ;
    else
        %retrieve dense grayscale SIFT features 
        [f,~] = vl_sift(grayscale_image) ;
        
        %find the features at the positions of the grayscale features
        [~, R_sift] = vl_sift(im2single(image(:,:,1)), 'frames', f);
        [~, G_sift] = vl_sift(im2single(image(:,:,2)), 'frames', f);
        [~, B_sift] = vl_sift(im2single(image(:,:,3)), 'frames', f);
        
        %construct colorSift (channels based on the sift type)
        sift = cat(1, R_sift, G_sift, B_sift);
    end
end

end