function [transformed] = image_transform(image, T)
    % corners will always be the most extremely located pixels. We know no
    % pixel will be right from the rightmost corner, left from the leftmost
    % corner, above the highest or below the lowest
    corners = [1 1 1; 1 size(image, 1) 1 ;size(image, 2) 1 1; size(image, 2) size(image, 1) 1];
    
    % let's see where these extreme points lie after transforming
    new_corners = corners*T;
    left_c = min(new_corners(:, 1)); % leftmost corner: min x coordinate
    right_c = max(new_corners(:, 1)); % rightmost corner x coordinate
    top_c = min(new_corners(:, 2)); % top corner y coordinate
    bottom_c = max(new_corners(:, 2)); % bottom corner y coordinate

    % offset_x help us deal with pixels that, after transformation, are
    % left on the negative part of the horizonatl axis. We'll find whose
    % the most negative x coordinate and then we will move everybody to the
    % right by this offset plus 1 (since the image coordinate system starts
    % in (1, 1)
    offset_x = 0;
    if left_c < 1 % if transformed leftmost x coordinate is out of the frame
        offset_x = abs(left_c)+1; % then its absolute value + 1 is our x offset
    end

    % now check if the top corner is off the chart to use its y coordinate
    % + 1 as the vertical offset for every pixel. Do note: these x and y
    % offsets have nothing to do with the translation part of the
    % transformation (if any). Those other offsets will be taken care of
    % below
    offset_y = 0;
    if top_c < 1
        offset_y = abs(top_c)+1;
    end
    
    % define image dimensions
    width = ceil(right_c + offset_x); % image expands horizontally up to righmost corner x coordinate plus x offset
    height = ceil(bottom_c + offset_y); % and vertically in a similar way
    transformed = zeros(height, width, size(image, 3)); % a buffer for our transformed image

    % each new pixel coordinates are the result of applying T to old image
    % pixels. To go the other way around (i.e. from new coordinates back to
    % their corresponding old coordinates), we apply the inverted
    % transformation: think for instance, the transformation was something
    % as simple as scaling up. Then every new pixel location will be an old
    % pixel location multiplied by the scaling factor. To go back from new
    % coordinates to old, you would scale down the new coordinates by
    % dividing by the scaling factor cause that's the opposite
    % transformation
    pinv_T = pinv(T);

    % Traverse every pixel in the new image space. Its important to find
    % the closest match of each new pixel instead of finding the image of
    % each old pixel. The former approach will find a value for every
    % transformed location, whereas the latter might leave some new
    % locations without a value, resulting in weird black dots in the image
    for new_x = 1:width
        for new_y = 1:height

            % remember we added offsets? Time to revert them
           old_coords = [new_x - offset_x, new_y - offset_y, 1]*pinv_T;
           % it's important to round. That ensures result is integer and
           % that its value will be the the closest match possible. This is
           % the part that is actually doing the closest neighbor
           % interpolation
           old_x = int64(round(old_coords(1)));
           old_y = int64(round(old_coords(2)));
           % remember the new image might be framed by black pixels to
           % ensure it's square even if original was rotated. This black
           % pixels don't correspond to anything in the old image so we
           % should be left black
           if old_x >= 1 && old_x <= size(image, 2) && old_y >= 1 && old_y <= size(image, 1)
               transformed(new_y, new_x, :) = image(old_y, old_x, :);
           end
        end
    end
    transformed=uint8(transformed);
end