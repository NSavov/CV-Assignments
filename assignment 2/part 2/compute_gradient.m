function [im_magnitude, im_direction] = compute_gradient(image)
% COMPUTE_GRADIENT calculates the intensity change gradient at each pixel 
% for a given image in greyscale
%   image: input image to calculate gradients on
%   im_magnitude: matrix with  the norms of the intensity change gradients 
%   at each pixel
%   im_direction: matrix with the angles (wrt x axis) of the intensity
%   change gradients at each pixel

    %our kernel to calculate the gradient's y value. It has 0 in the middle
    %row since we only care about difference between upper row and lower
    %row. The middle values are worth more to emphasize vertical intensity
    %changes over non totally vertical changes. The bigger the intensity
    %difference between upper and lower rows, the bigger the magnitude of
    %the gradient's y coordinate at this point
    grad_y = [1 +2 +1; 0 0 0; -1 -2 -1];
    grad_x = [-1 0 1; -2 0 2; -1 0 1];
    % Gx is the matrix with the x coordinates of the intensity change
    % gradient at each pixel
    Gx = conv2(image, grad_x);
    Gy = conv2( image, grad_y);
    
    % compute magnitude and direction of the gradients
    im_magnitude = sqrt(Gx.^2+Gy.^2);
    % atan2 gives us the angles of the vectors defined by Gy and Gx in
    % radians (x/y is the tan of the angle, so taking arctan of
    % that gives you the angle itself, but atan2 doesn't require us to do
    % the division). We convert this to degrees 
    im_direction = (atan2(Gy,Gx))*180/pi;
    
    %plot everything
    subplot(221);
    imshow(Gx, [])
    title('Gradient X')
    
    subplot(222);
    imshow(Gy, [])
    title('Gradient Y')
    
    subplot(223);
    imshow(uint8(im_magnitude), [])
    title('Magnitude')
    
    subplot(224);
    imshow(im_direction, [])
    title('Direction')
    
end