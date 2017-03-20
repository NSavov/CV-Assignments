function [histogram] = visual_word_histogram(image, centroids, feature_method, sift_type, feature_file_path)
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
    
    warning('off', 'stats:kmeans:FailedToConverge');
    
    n_centroids = size(centroids, 1);
    
    load(feature_file_path, 'sift');
    d = sift;
    
    
%     d = extract_sift(image, feature_method, sift_type, sample_size);
    % point_mapping(i) is the cluster point i maps to
    d = d';
    n_d = size(d, 1);
    if n_d < n_centroids
        d =  cat(1, d,repmat(d(end, :),n_centroids-n_d,1));
    end
    
    point_mapping = kmeans(double(d), n_centroids,'MaxIter',1,'Start',centroids);

    if n_d < n_centroids
        point_mapping = point_mapping(1:n_d, :);
    end
%     point_mapping
    minimum = min(point_mapping);
    maximum = max(point_mapping);
    pad1 = zeros(1,minimum-1);
    pad2 = zeros(1,n_centroids-maximum);
    histogram = histcounts(point_mapping, maximum-minimum+1);
%     histogram
    histogram = cat(2, pad1, histogram, pad2);
%     histogram
%     histogram
    
    histogram = histogram ./ max(histogram);
    warning('on', 'stats:kmeans:FailedToConverge');
end
