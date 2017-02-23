%this was not needed for the homework but still wanted to do it just
%because
%http://www.songho.ca/dsp/convolution/convolution.html
function G = gauss2( sigma , kernel_size )
    G = zeros(kernel_size, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter matrix will not have a center to convolve on')
    end
    radius = floor(kernel_size/2);
    for x = -radius:radius
        for y = -radius:radius
            G(x + radius + 1, y + radius + 1) = exp((-1/2)*(x^2 + y^2)/sigma^2)/(sigma*sqrt(2*pi));
        end
    end
    G = G./sum(G(:));
end