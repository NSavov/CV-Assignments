function [imOut, Gd] = gaussDer(image, G, sigma)
    Gd = zeros(1, size(G, 2), 'double');
    radius = floor(size(G, 2)/2);
    for x = -radius:radius
        Gd(x + radius + 1) = (- x/(sigma^2))*G(x + radius + 1);
    end
    imOut = conv2(image, Gd);
    
end