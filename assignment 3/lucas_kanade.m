function [Vx, Vy] = lucas_kanade(image1, image2, window_size)
    [Ix, Iy] = imgradientxy(image1); % take derivatives of intensity over space
    sizex = size(image1, 1);
    sizey = size(image1, 2);
    It = double(image2) - double(image1); % take derivative of intensity over time
    Vx = zeros(floor(sizex/window_size), floor(sizey/window_size)); % split image in window_size square regions and get optical flow vector for each one
    Vy = zeros(floor(sizex/window_size), floor(sizey/window_size));
    for wx = 1:window_size:sizex - window_size % browse each region
        for wy = 1:window_size:sizey - window_size
            region_Ix = Ix(wx:(wx+window_size), wy:(wy+window_size)); % get the window region
            region_Iy = Iy(wx:(wx+window_size), wy:(wy+window_size));
            region_It = It(wx:(wx+window_size), wy:(wy+window_size));
            A = [region_Ix(:) region_Iy(:)]; % 2x2 matrix with coefficients for x and y gradients
            b = -region_It(:); % vector b with results
            %solution = linsolve(A, b);
            solution = pinv(A)*b; % solve linear over determined system (as many equations as pixels in the region, but only 2 unknowns)
            Vx(1+(wx-1)/window_size, 1+(wy-1)/window_size) = solution(1); % velocity x coord is solution to first unknown
            Vy(1+(wx-1)/window_size, 1+(wy-1)/window_size) = solution(2);
        end
    end
end