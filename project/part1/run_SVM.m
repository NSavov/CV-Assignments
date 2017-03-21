globals;
feature_methods = {'keypoint', 'dense'};
sift_types = {'grayscale', 'RGB', 'norm_rgb', 'opponent'};

start = vocabulary_fraction+1;
histogram_file_suffix = strcat('_', num2str(vocabulary_size));
results = {};

for feature_method_i=1:size(feature_methods,2)
    feature_method = feature_methods{feature_method_i};
    for sift_type_i=1:size(sift_types,2)
        sift_type = sift_types{sift_type_i};
        models = train_SVM(feature_method, sift_type, svm_kernel, start, svm_train_set_size, image_categories_train, histogram_file_suffix);
        [mAP, ap, ranking, ranking_fileName] = predict_SVM(feature_method, sift_type, models, svm_test_set_size, image_categories_test, histogram_file_suffix);
        generate_results_html(feature_method, sift_type, ap, mAP, ranking_fileName{1}, vocabulary_size,vocabulary_fraction, sift_block_size, sift_step_size, svm_train_set_size, svm_kernel);
%         results{feature_method_i*sift_type_i} = [map, ap, ranking, ranking_fileName];
    end
end

% celldisp(results)