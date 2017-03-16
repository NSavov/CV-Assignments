function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
    r = input_image(:,:,1);
    g = input_image(:,:,2);
    b = input_image(:,:,3);

    output_image = input_image(:,:,:);
    output_image(:,:,1) = r./(r+g+b);
    output_image(:,:,2) = g./(r+g+b);
    output_image(:,:,3) = b./(r+g+b);
end

