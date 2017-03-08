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
    % convolve the derivatives of the intensities with a gaussian kernel
    A = conv2( Ixx, gkernel, 'same');
    % In theory A, B and C are scalars but since we'll have one of them for
    % each pixel, we are saving them in this A, B and C matrices
    C = conv2(Iyy, gkernel, 'same');
    B = conv2(Ixy, gkernel,  'same');

    size_x = size(image, 1);
    size_y = size(image, 2);
    
    % the cornerness formula: det(H) - 0.04*trace(H). In theory, H is a 2x2
    % matrix, and we have one H per pixel, so we gather all of these such
    % results into a single size_x by size_y H matrix
    H = (A.*C - B.*B) - 0.04*(A+C).*(A+C);
    
    % now we'll use a trick: when there is a corner, several pixels can get
    % a high H score, just because they all share the corner neighborhood.
    % We want only one of them to be the corner. So we now explore each
    % value of H to find out if its the biggest of its neighborhood. And 
    % only so we check if it also passes the corner criteria.
    filter_window_size = 15;
    c = [];
    r = [];
    % H = H./max(max(H));
    threshold = mean(H(H>0))*1.8;
    %here we go, explore every value in H
    for x = 1:filter_window_size:size_x - filter_window_size
        for y = 1:filter_window_size:size_y - filter_window_size
            % if the biggest value in the 'hood passes cornerness criteria
            if max(max(H(x:x+filter_window_size,y:y+filter_window_size))) > threshold
                % then we gather its coordinates in c and r arrays. Not
                % elegant at all but it works at least
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