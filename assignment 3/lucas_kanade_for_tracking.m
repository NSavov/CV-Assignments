function [Vx, Vy] = lucas_kanade_for_tracking(image1, image2, window_size, c, r)
%Given a sequence of two grayscale images, computes the lucas-kanade
%algorithm on them to find the velocities in every region (of a given size)
%centered at given coordinates in the images
%image1 - first frame of the sequence
%image2 - second frame of the sequence
%window_size - window size
%c - x coordinates of the points of interest. The algorithm will calculate
%the velocities at square regions of window_size by window_size centered at
%the coordinates given by c and r. That is, the amount of arrows produced
%equals the lenght of c or r
%r - y coordinates of the points of interest. The algorithm will calculate
%the velocities at square regions of window_size by window_size centered at
%the coordinates given by c and r. That is, the amount of arrows produced
%equals the lenght of c or r
%Vx - x coordinates of the velocities. The velocity of the i'th window is
%given by (Vx(i), Vy(i))
%Vy - y coordinates of the velocities. The velocity of the i'th window is
%given by (Vx(i), Vy(i))
    [Ix, Iy] = imgradientxy(image1);
    sizex = size(image1, 1);
    sizey = size(image1, 2);
    It = double(image2) - double(image1);
    Vx = [];
    Vy = [];
    for i = 1:size(c,2)
            %calculate the center of each window
            wx = r(i)-floor(window_size/2)+1;
            wy = c(i)-floor(window_size/2)+1;
            %control for boundary conditions at the coordinates. If the
            %point of interest is not compatible with the window size, then
            %no velocity for that point
            if wx<=0 || wy<=0 || (wx+window_size) > sizex || (wy+window_size) > sizey
                Vx = [Vx 0];
                Vy = [Vy 0];
                continue
            end
            %from here onwards, lucas_kanade all the way
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