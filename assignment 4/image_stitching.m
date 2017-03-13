function [stitched] = image_stitching(source, matching, T, combination_method)
% stitches an image matching to another image source, by applying a given
% transformation T to matching, using 1 of three possible combination methods
% source: base image (it won't be transformed)
% matching: image to stitch to image1, by applying T transformation to it
% T: affine transformation applied to matching so that it can be stitched to
% source
% combination_method: string to determine average_overlap, max or average
% stitched: stitched image
    % apply transformation
    transformed = image_transform(matching, T);
    
    % find transformed corners
    corners = [1 1 1; 1 size(matching, 1) 1 ;size(matching, 2) 1 1; size(matching, 2) size(matching, 1) 1];
    new_corners = corners*T;
    
    % determine min x and y coordinates from the corners
    left_c = min(new_corners(:, 1)); % leftmost x coordinate
    top_c = min(new_corners(:, 2)); % topmost y coordinate
    
    % now get our offsets: source image should be offset by these so that
    % it aligns with transformed matching image
    translate_source_x = 0;
    if left_c < 1
        translate_source_x = abs(left_c) + 1;
    end
    translate_source_y = 0;
    if top_c < 1
        translate_source_y = abs(top_c) + 1;
    end
    source = imtranslate(source,[translate_source_x, translate_source_y],'OutputView','full');

    %///////
    %Padding:
    %///////
    % both images need to be of the same size now, filling the missing part
    % with padding 0s so that we can afterwards simply stack them on top of
    % one another and let one's intensity replaces the other's padding
    % black
    pad_source_x = 0;
    pad_matching_x = 0;
    pad_source_y = 0;
    pad_matching_y = 0;
    % if width of transformed > width source
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
    % now pad!
    source = padarray(source,[pad_source_x, pad_source_y],0,'post');
    transformed = padarray(transformed,[pad_matching_x, pad_matching_y],0,'post');

    % buffer for our output image
    stitched = zeros(size(transformed));

    % check required combination method
    if strcmp(combination_method, 'average_overlap')
        for x = 1:size(stitched,1)
            for y = 1:size(stitched, 2)
                % if source is black
                if sum(source(x,y,:)) == 0 % take the intensity from the other
                    value = transformed(x,y,:);
                elseif sum(transformed(x,y,:)) == 0 % or the other way around
                    value = source(x,y,:);
                else % if both have black sum over their channels, take average
                    value = (transformed(x,y,:)/2 + source(x,y,:)/2);
                end
                stitched(x,y,:) = value;
            end
        end
    end
    % a simpler method: just pick the highest value, so the black always
    % dies
    if strcmp(combination_method, 'max')
        stitched = max(source, transformed);
    end
    % and finally, use average
    if strcmp(combination_method, 'average')
        stitched = (source + transformed)/2;
    end
    stitched = uint8(stitched);
end