function [transformed] = image_transform(image, T)
corners = [1 1 1; 1 size(image, 1) 1 ;size(image, 2) 1 1; size(image, 2) size(image, 1) 1];

new_corners = corners*T;
left_c = min(new_corners(:, 1));
right_c = max(new_corners(:, 1));
top_c = min(new_corners(:, 2));
bottom_c = max(new_corners(:, 2));

offset_x = 0;
if left_c < 1
    offset_x = abs(left_c)+1;
end

offset_y = 0;
if top_c < 1
    offset_y = abs(top_c)+1;
end

width = ceil(right_c + offset_x);
height = ceil(bottom_c + offset_y);
transformed = zeros(height, width);

pinv_T = pinv(T);

for new_x = 1:width
    for new_y = 1:height

       old_coords = [new_x - offset_x, new_y - offset_y, 1]*pinv_T;
       old_x = int64(round(old_coords(1)));
       old_y = int64(round(old_coords(2)));
       if old_x >= 1 && old_x <= size(image, 2) && old_y >= 1 && old_y <= size(image, 1)

           transformed(new_y, new_x) = image(old_y, old_x);
       end
    end
end

transformed=uint8(transformed);
end