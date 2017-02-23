function [im_magnitude, im_direction] = compute_gradient(image)

    %perform convolution to get the gradient
    grad_y = [1 +2 +1; 0 0 0; -1 -2 -1];
    grad_x = [-1 0 1; -2 0 2; -1 0 1]; %grad_y';
    Gx = conv2(image, grad_x);
    Gy = conv2( image, grad_y);
    
    %compute magnitude and direction of the gradients
    im_magnitude = sqrt(Gx.^2+Gy.^2);
    im_direction = (atan(Gx./Gy)+pi/2)*180/pi; %atan2(-Gy,Gx)*180/pi;
    
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
    imshow(uint8(im_direction), [])
    title('Direction')
    
   %test using the built-in functions
    figure()
    [Gx, Gy] = imgradientxy(image, 'sobel');
    [im_magnitude, im_direction] = imgradient(Gx, Gy);
    subplot(221)
    imshow(Gx, [])
    subplot(222)
    imshow(Gy, [])
    subplot(223)
    imshow(uint8(im_magnitude), [])
    subplot(224)
    imshow(uint8(im_direction), [])
end