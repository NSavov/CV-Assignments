function [H, r, c] = harris(image, n, threshold, sigmaD, sigmaP)
%image - input image
%n - window size
%threshold - H threshold
%sigmaD - derivative gaussian sigma
%sigmaP - window gaussian sigma
original = image(:, :, :);
if size(image, 3) > 1
    image = rgb2gray(image);
end
f = fspecial('gaussian', [3 3], sigmaD);
[Gx,Gy] = gradient(f);
Ix = conv2(image, Gx, 'same');

Iy = conv2(image, Gy, 'same');
Ixx = Ix.*Ix;
Iyy = Iy.*Iy;
Ixy = Ix.*Iy;
gkernel = fspecial('gaussian', [3 3], sigmaP);
Sxx = conv2( Ixx, gkernel, 'same');
Syy = conv2(Iyy, gkernel, 'same');
Sxy = conv2(Ixy, gkernel,  'same');

size_x = size(image, 1);
size_y = size(image, 2);

size(Sxx)
%padarray(image, [(n-1)/2, (n-1)/2])
    half_window = (n-1)/2;
    Q = zeros(size_x, size_y, 2, 2);
    for x = 1:size_x
        for y = 1:size_y
            Q(x,y, :, :) = [Sxx(x, y) Sxy(x, y); Sxy(x, y) Syy(x, y)];
        end
    end
    
    H = zeros(size_x, size_y);
    
    for x = half_window+1:size_x-half_window-1
        for y = half_window+1:size_y-half_window-1
            sumQ = zeros(2,2);
            for u = x-half_window:x+half_window
                for v =  y-half_window:y+half_window
                    
                     sumQ = sumQ + reshape(Q(u,v, :, :), [2 2]);
                end
            end
            e = eig(sumQ);
            H(x,y) = e(1)*e(2)-0.04*(e(1) + e(2))^2;
        end
    end
    
    H(H<threshold) = 0;
    indices = find(H>0)-1;
    
    size(indices)
    
    r = idivide(int64(indices), int64(size_y)) + 1;
    c = mod(int64(indices), int64(size_x)) + 1;

    subplot(131)
    imshow(Ix,[])

    subplot(132)
    imshow(Iy,[])

    subplot(133)
    imshow(original,[])
    hold on
    %original(r,c,1) = 255;
    scatter(r, c, 'r.')
    hold off
    
end