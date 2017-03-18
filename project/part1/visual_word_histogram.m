function [histogram] = visual_word_histogram(image, centroids, feature_method, sift_type, sample_size)
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
    d = extract_sift(image, feature_method, sift_type, sample_size);
    % point_mapping(i) is the cluster point i maps to
    d = d';
    n_d = size(d, 1);
    if n_d < n_centroids
        d =  cat(1, d,repmat(d(end, :),n_centroids-n_d,1));
    end
    point_mapping = kmeans(double(d), n_centroids,'MaxIter',1,'Start',centroids);
    
    if n_d < n_centroids
        point_mapping = point_mapping(n_d, :);
    end
    
    histogram = histcounts(point_mapping, n_centroids);
    histogram = histogram ./ sum(histogram);
end
