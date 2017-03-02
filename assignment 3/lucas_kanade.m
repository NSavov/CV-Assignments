function [Vx, Vy] = lucas_kanade(image1, image2, window_size)
    [Ix, Iy] = imgradientxy(image1);
    sizex = size(image1, 1);
    sizey = size(image1, 2);
    It = double(image2) - double(image1);
    Vx = zeros(floor(sizex/window_size), floor(sizey/window_size));
    Vy = zeros(floor(sizex/window_size), floor(sizey/window_size));
    for wx = 1:window_size:sizex - window_size
        for wy = 1:window_size:sizey - window_size
            region_Ix = Ix(wx:(wx+window_size), wy:(wy+window_size));
            region_Iy = Iy(wx:(wx+window_size), wy:(wy+window_size));
            region_It = It(wx:(wx+window_size), wy:(wy+window_size));
            A = [region_Ix(:) region_Iy(:)];
            b = -region_It(:);
            %solution = linsolve(A, b);
            solution = pinv(A)*b;
            Vx(1+(wx-1)/window_size, 1+(wy-1)/window_size) = solution(1);
            Vy(1+(wx-1)/window_size, 1+(wy-1)/window_size) = solution(2);
            %iterate over the pixels in the window around the selected pixel
        end
    end
end