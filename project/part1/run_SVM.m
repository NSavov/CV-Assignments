globals;
feature_methods = {'keypoint'};%, 'dense'};
sift_types = {'grayscale', 'RGB', 'norm_rgb', 'opponent'};

start = 251;
kernel='linear';
histogram_file_suffix = '_400';

results = {};

for feature_method_i=1:1%size(feature_methods,2)
    feature_method = feature_methods{feature_method_i};
    for sift_type_i=1:1%size(sift_types,2)
        sift_type = sift_types{sift_type_i};
        models = train_SVM(feature_method, sift_type, svm_kernel, start, svm_train_set_size,histogram_file_suffix);
        [map, ap, ranking, ranking_fileName] = predict_SVM(feature_method, sift_type, models, svm_test_set_size,histogram_file_suffix);
        results{feature_method_i*sift_type_i} = [map, ap, ranking, ranking_fileName];
    end
end

% celldisp(results)