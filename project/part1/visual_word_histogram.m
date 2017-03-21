function [histogram] = visual_word_histogram(image, centroids, sift)
    % calculates the normalized histogram of visual word counts of an image
    % image: image to calculate histogram on. Can be RGB, rgb, grayscaled
    % or opponent color spaced
    % centroids: matrix with the centroids (the visual words). Each row is
    % a centroid, each column a dimension of the centroid space
    % feature_method: sift feature extraction method. Can be either 'dense'
    % or 'keypoint'
    % histogram: normalized histogram of visual word counts for the image.
    % histogram(i) is the proportion of times word i is present in the
    % image
    
    
    n_centroids = size(centroids, 1);
       
    point_mapping = knnsearch(double(centroids), double(sift));

    minimum = min(point_mapping);
    maximum = max(point_mapping);
    pad1 = zeros(1,minimum-1);
    pad2 = zeros(1,n_centroids-maximum);
    histogram = histcounts(point_mapping, maximum-minimum+1);
    histogram = cat(2, pad1, histogram, pad2);
    histogram = histogram ./ max(histogram);
end
