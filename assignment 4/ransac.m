function [T] = ransac(image1, image2, N, subset_size)

    [all_matches, ~, f1, f2] = match_features(image2, image1);
    
    threshold_distance = 10;
    
    best_inliers = 0;
    

    for i = 1:N
        
        T = [1 0 0; 0 1 0; 0 0 1];
        inliers = 0;
        perm = randperm(size(all_matches,2)) ;
        selected = perm(1:subset_size);
        matches = all_matches(:,selected);
        
        %we need 3 matches
        
        x = f1(1, matches(1, :));
        y = f1(2, matches(1, :));
        
        xt = f2(1, matches(2, :));
        yt = f2(2, matches(2, :));
        
        A = [];
        for k = 1:subset_size
            A_temp = [x(k), y(k), 0, 0, 1, 0; 
                      0, 0, x(k), y(k), 0, 1];
            A = cat(1, A, A_temp);
        end
        
        b = [xt; yt];
        b = b(:);
        
        t = pinv(A)*b;
        
        
        t = [t(1) t(3) 0; t(2) t(4) 0; t(5) t(6) 1];
        
        for k = 1:size(all_matches, 2)
            coords_original = [f1(1, all_matches(1,k)), f1(2, all_matches(1,k)), 1];
            coords_expected = [f2(1, all_matches(2,k)), f2(2, all_matches(2,k)), 1];
            coords_result = coords_original*t;
            distance = sqrt(sum((coords_result - coords_expected).^2));
%             distance
            if distance < threshold_distance
            	inliers = inliers + 1;
            end
        end
        
        
        if inliers>best_inliers
%             inliers
            best_inliers = inliers;
            T = t;
        end
    end
    T = t;
end