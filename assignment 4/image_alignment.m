function [] = image_alignment(image1, image2, subset_size, combine_method)
% ransac doesn't care that the right image has extra stuff that the left
% image doesn't. vl_feat will find common features that ransac can try to
% match anyway. Ransac won't try to match every pixel in the image, only
% some of those that vl_feat found to be good matches

T = ransac(image1, image2, 100, subset_size);

stitched = image_stitching(image1, image2, T, combine_method);

imshow(stitched);
end