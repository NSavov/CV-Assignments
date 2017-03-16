function [histogram] = visual_word_histogram(image, centroids, feature_method)
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
    
    'WARNING: function not fully implemented yet'
    n_centroids = size(centroids, 1);
    [~, d] = extract_descriptors(image, feature_method);
    % point_mapping(i) is the cluster point i maps to
    point_mapping = kmeans(d, n_centroids,'MaxIter',1,'Start',centroids);
    histogram = histcounts(point_mapping, n_centroids);
    histogram = histogram ./ sum(histogram);
end
