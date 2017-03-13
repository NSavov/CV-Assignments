function [T] = ransac(first, matching, N, subset_size)
% given two images first and matching, uses vl_feat to find the best linear
% transformation from matching to first
% first: target image to be achieved by transforming matching
% matching: image to transform and match into first
% N: number of ransac iterations
% subset_size: number of matching features to consider in each ransac
% iteration. Must be less than the total number of matches found by vl_feat
% T: affine transformation matrix that converts matchint to first
    
    % make sure images are grayscaled
    if size(first,3) > 1
        first = rgb2gray(first);
    end

    if size(matching,3) > 1
        matching = rgb2gray(matching);
    end
    % get vl_feat features
    [all_matches, ~, f1, f2] = match_features(matching, first);
    
    % number of pixels we allow a transformed coordinate from matching to
    % drift away from our gold rule (the coordinates of the respective
    % feature in f1). Every transformed pixel that falls within this range
    % from its golden standard is considered an inlier
    threshold_distance = 10;
    
    % to hold our best result so far
    best_inliers = 0;
    
    % by default, we start by assuming T is the identity matrix
    T = [1 0 0; 0 1 0; 0 0 1];
    for i = 1:N % for N iterations
              
        inliers = 0;
        % pick random subset_size matching points
        perm = randperm(size(all_matches,2)) ;
        selected = perm(1:subset_size);
        matches = all_matches(:,selected);
        
        %we need 3 matches
        % pick all the matching feature coordinates from matching image in our random sample
        x = f1(1, matches(1, :));
        y = f1(2, matches(1, :));
        %pick the corresponding matching feature coordinates from the first image
        xt = f2(1, matches(2, :));
        yt = f2(2, matches(2, :));
        
        A = [];
        for k = 1:subset_size % go through each such matching points from our sample
            A_temp = [x(k), y(k), 0, 0, 1, 0; 
                      0, 0, x(k), y(k), 0, 1];
            A = cat(1, A, A_temp);
        end
        
        b = [xt; yt];
        b = b(:);
        % solve the linear system
        t = pinv(A)*b;
        
        % reshape t
        t = [t(1) t(3) 0; t(2) t(4) 0; t(5) t(6) 1];
        
        % build a matrix with coordinates of the features, x in first row,
        % y in second and 1s in third (homogeneous coordinates, needed for the translation part)
        coords_original = [f1(1, all_matches(1,:)); f1(2, all_matches(1,:)); ones(1, size(all_matches, 2))]';
        coords_expected = [f2(1, all_matches(2,:)); f2(2, all_matches(2,:)); ones(1, size(all_matches, 2))]';
        % transformed coordinates from matching image
        coords_result = coords_original*t;
        % a vector with all the distances
        distance = sqrt(sum((coords_result - coords_expected).^2, 2));
        % checking inliers
        inliers = size(distance(distance<=threshold_distance), 1);
        
        % check if we have a new favorite and save its T if so
        if inliers > best_inliers
            best_inliers = inliers;
            T = t;
        end
    end
end