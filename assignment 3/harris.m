function [Ix, Iy, H, r, c] = harris(image, n, threshold, sigmaD, sigmaP)
%image - input image
%n - window size
%threshold - H threshold
%sigmaD - derivative gaussian sigma
%sigmaP - window gaussian sigma
    
    gauss_size = n;

    %convert to grayscale if it is not
    if size(image, 3) > 1
        image = rgb2gray(image);
    end
    
    %pad the image with zeroes, so we can calculate the edges on the border
    %image = padarray(image, [half_window, half_window]);
    
    %calculate the x and y gradients
    f = fspecial('gaussian', [5 5], sigmaD);
    [Gx,Gy] = gradient(f); % Gx is the partial derivative of a Gaussian kernel
    %over the x axis. Therefore it is positive to the left (over negative x
    %values, where the curve grows), gets to zero (at the mean, where the
    %curve's slope reaches 0) and then negative over the positive x values
    %(where the slope goes down). Gy will be the transpose of this for
    %analogous reasons
    Ix = conv2(image, Gx, 'same'); 
    Iy = conv2(image, Gy, 'same');
    
    %calculate the elements of the matrix to sum for each pixel
    Ixx = Ix.*Ix; % remember the definition of Q. We need all this combinations of Ix and Iy
    Iyy = Iy.*Iy;
    Ixy = Ix.*Iy;
    gkernel = fspecial('gaussian', [gauss_size gauss_size], sigmaP); % the autocorrelation
    % weights every pixel intensity with a gaussian distribution: that is,
    % convolve the intensities with a gaussian kernel
    A = conv2( Ixx, gkernel, 'same');
    C = conv2(Iyy, gkernel, 'same');
    B = conv2(Ixy, gkernel,  'same');

    size_x = size(image, 1);
    size_y = size(image, 2);
    
    H = (A.*C - B.*B) - 0.04*(A+C).*(A+C);
    
    filter_window_size = 15;
    c = [];
    r = [];
    % H = H./max(max(H));
    threshold = mean(H(H>0))*1.8
    for x = 1:filter_window_size:size_x - filter_window_size
        for y = 1:filter_window_size:size_y - filter_window_size
            if max(max(H(x:x+filter_window_size,y:y+filter_window_size))) > threshold
                [values, indexes] = max(H(x:x+filter_window_size,y:y+filter_window_size));
                [~, index_x] = max(values);
                corner_y = indexes(index_x);
                corner_y = corner_y + y - 1;
                index_x = index_x + x - 1;
                c = [c, corner_y];
                r = [r, index_x];
            end
        end
    end
end