%executes training and testing SVMs classifiers for all categories, SIFT
%generation methods and SIFT types, using the parameters defined in globals
%saves the results into HTML files

globals;
feature_methods = {'keypoint', 'dense'};
sift_types = {'grayscale', 'RGB', 'norm_rgb', 'opponent'};

%make sure not to train on images used for vocabulary construction:
start = vocabulary_fraction+1;

%identify histograms files
histogram_file_suffix = strcat('_', num2str(vocabulary_fraction));

if vocabulary_size ~= 400
    histogram_file_suffix = strcat(histogram_file_suffix, '_', num2str(vocabulary_size));
end

results = {};
maps = zeros(2,4);
aps = zeros(2, 4, 4);

%iterate over SIFT methods and types
for feature_method_i=1:size(feature_methods,2)
    feature_method = feature_methods{feature_method_i};
    for sift_type_i=1:size(sift_types,2)
        sift_type = sift_types{sift_type_i};
        
        %train an SVM classifier on the train set
        models = train_SVM(feature_method, sift_type, svm_kernel, start, svm_train_set_size, image_categories_train, histogram_file_suffix);
        
        %test the SVM classifier on the test set
        [mAP, ap, ranking, ranking_fileName] = predict_SVM(feature_method, sift_type, models, svm_test_set_size, image_categories_test, histogram_file_suffix);
        
        %generate HTML file
        generate_results_html(feature_method, sift_type, ap, mAP, ranking_fileName{1}, vocabulary_size,vocabulary_fraction, sift_block_size, sift_step_size, svm_train_set_size, svm_kernel);
        
        %store results
        maps(feature_method_i,sift_type_i) = mAP;
        aps(feature_method_i,sift_type_i, :) = ap;
%         results{feature_method_i*sift_type_i} = [map, ap, ranking, ranking_fileName];
    end
end



% celldisp(results)