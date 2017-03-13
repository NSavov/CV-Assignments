function [] = image_stitching(image1, image2, T, combination_method)
% source = rgb2gray(image1);
% matching = rgb2gray(image2);
source = image1;
matching = image2;


% warpT = affine2d( T);
% transformed = imwarp(matching, warpT); %,'OutputView', imref2d(size(image2))
transformed = image_transform(matching, T);

corners = [1 1 1; 1 size(matching, 1) 1 ;size(matching, 2) 1 1; size(matching, 2) size(matching, 1) 1];

new_corners = corners*T;

left_c = min(new_corners(:, 1));
right_c = max(new_corners(:, 1));
top_c = min(new_corners(:, 2));
bottom_c = max(new_corners(:, 2));

translate_source_x = 0;
if left_c < 1
    translate_source_x = abs(left_c) + 1;
end

translate_matching_x = 0;
if left_c > 1
    translate_matching_x = left_c - 1;
end

translate_source_y = 0;
if top_c < 1
    translate_source_y = abs(top_c) + 1;
end

translate_matching_y = 0;
if top_c > 1
    translate_matching_y = top_c - 1;
end


source = imtranslate(source,[translate_source_x, translate_source_y],'OutputView','full');
% transformed = imtranslate(transformed,[translate_matching_x, translate_matching_y],'OutputView','full');

%/////////////////////////////////
pad_source_x = 0;
pad_matching_x = 0;
pad_source_y = 0;
pad_matching_y = 0;

if size(transformed, 2) - size(source, 2) > 0
    pad_source_y = size(transformed, 2) - size(source, 2);
else
    pad_matching_y = size(source, 2) - size(transformed, 2) ;
end

if size(transformed, 1) - size(source, 1) > 0
    pad_source_x = size(transformed, 1) - size(source, 1);
else
    pad_matching_x = size(source, 1) - size(transformed, 1) ;
end


source = padarray(source,[pad_source_x, pad_source_y],0,'post');
transformed = padarray(transformed,[pad_matching_x, pad_matching_y],0,'post');

stitched = zeros(size(transformed));

if strcmp(combination_method, 'average_overlap')
    for x = 1:size(stitched,1)
        for y = 1:size(stitched, 2)

            if sum(source(x,y,:)) == 0
                value = transformed(x,y,:);
            elseif sum(transformed(x,y,:)) == 0
                value = source(x,y,:);
            else
                value = (transformed(x,y,:)/2 + source(x,y,:)/2);
            end

            stitched(x,y,:) = value;
        end
    end
end

if strcmp(combination_method, 'max')
    stitched = max(source, transformed);
end

if strcmp(combination_method, 'average')
    stitched = (source + transformed)/2;
end

stitched = uint8(stitched);
% transformed(1:translate_matching_x, :)
imshow(stitched);
imwrite(stitched, 'stitched.jpeg')
end