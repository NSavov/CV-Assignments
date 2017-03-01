function [H, r, c] = harris(image, n, threshold, sigmaD, sigmaP)
%image - input image
%n - window size
%threshold - H threshold
%sigmaD - derivative gaussian sigma
%sigmaP - window gaussian sigma

    %backup the original image for plotting
    original = image(:, :, :);
    
    half_window = (n-1)/2;
    
    %convert to grayscale if it is not
    if size(image, 3) > 1
        image = rgb2gray(image);
    end
    
    %pad the image with zeroes, so we can calculate the edges on the border
    %image = padarray(image, [half_window, half_window]);
    
    %calculate the x and y gradients
    f = fspecial('gaussian', [3 3], sigmaD);
    [Gx,Gy] = gradient(f);
    Ix = conv2(image, Gx, 'same');
    Iy = conv2(image, Gy, 'same');
    
    %calculate the elements of the matrix to sum for each pixel
    Ixx = Ix.*Ix;
    Iyy = Iy.*Iy;
    Ixy = Ix.*Iy;
    gkernel = fspecial('gaussian', [3 3], sigmaP);
    Sxx = conv2( Ixx, gkernel, 'same');
    Syy = conv2(Iyy, gkernel, 'same');
    Sxy = conv2(Ixy, gkernel,  'same');

    size_x = size(image, 1);
    size_y = size(image, 2);
    H = zeros(size_x, size_y);
    
    %iterate over every pixel
    for x = half_window+1:size_x-half_window-1
        for y = half_window+1:size_y-half_window-1
            Q = zeros(2,2);
            %iterate over the pixels in the window around the selected pixel
            for u = x-half_window:x+half_window
                for v =  y-half_window:y+half_window
                    %calculate the Q matrix for the selected pixel
                     Q = Q + [Sxx(x, y) Sxy(x, y); Sxy(x, y) Syy(x, y)];%reshape(Q(u,v, :, :), [2 2]);
                end
            end
            %e = eig(sumQ);
            %calculate the H value for the selected pixel
            H(x,y) = det(Q) - 0.04*trace(Q);%e(1)*e(2)-0.04*(e(1) + e(2))^2;
        end
    end
    
    %leave only the pixels with H values higher than the threshold
    H(H<threshold) = 0;
    
    %find indices of the remaining positive H values
    [r,c] = find(H>0);
    
    %plots
    subplot(131)
    imshow(Ix,[])

    subplot(132)
    imshow(Iy,[])

%     subplot(133)
%     imshow(H, [])
    
    subplot(133)
    imshow(original,[])
    hold on
    scatter(c, r, 'r.')
    hold off
    
end