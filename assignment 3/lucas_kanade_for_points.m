function [Vx, Vy] = lucas_kanade_for_points(image1, image2, window_size, c, r, gaussian_sigma)
image1 = imgaussfilt(image1, gaussian_sigma);
image2 = imgaussfilt(image2, gaussian_sigma);
    [Ix, Iy] = imgradientxy(image1);
    sizex = size(image1, 1);
    sizey = size(image1, 2);
    It = double(image2) - double(image1);
    Vx = [];
    Vy = [];
    for i = 1:size(c,2)
            wx = r(i)-floor(window_size/2)+1;
            wy = c(i)-floor(window_size/2)+1;
            if wx<=0 || wy<=0 || (wx+window_size) > sizex || (wy+window_size) > sizey
                Vx = [Vx 0];
                Vy = [Vy 0];
                continue
            end
            
            region_Ix = Ix(wx:(wx+window_size), wy:(wy+window_size));
            region_Iy = Iy(wx:(wx+window_size), wy:(wy+window_size));
            region_It = It(wx:(wx+window_size), wy:(wy+window_size));
            A = [region_Ix(:) region_Iy(:)];
            b = -region_It(:);
            %solution = linsolve(A, b);
            solution = pinv(A)*b;
            Vx = [Vx solution(1)];
            Vy = [Vy solution(2)];
            %iterate over the pixels in the window around the selected pixel
    end
end