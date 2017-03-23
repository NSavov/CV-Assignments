globals;
feature_methods = {'keypoint', 'dense'};
sift_types = {'grayscale', 'RGB', 'norm_rgb', 'opponent'};

start = vocabulary_fraction+1;
histogram_file_suffix = strcat('_', num2str(vocabulary_fraction));

if vocabulary_size ~= 400
    histogram_file_suffix = strcat('_', num2str(vocabulary_size));
end
results = {};

maps = zeros(2,4);
for feature_method_i=1:size(feature_methods,2)
    feature_method = feature_methods{feature_method_i};
    for sift_type_i=1:size(sift_types,2)
        sift_type = sift_types{sift_type_i};
        models = train_SVM(feature_method, sift_type, svm_kernel, start, svm_train_set_size, image_categories_train, histogram_file_suffix);
        [mAP, ap, ranking, ranking_fileName] = predict_SVM(feature_method, sift_type, models, svm_test_set_size, image_categories_test, histogram_file_suffix);
        generate_results_html(feature_method, sift_type, ap, mAP, ranking_fileName{1}, vocabulary_size,vocabulary_fraction, sift_block_size, sift_step_size, svm_train_set_size, svm_kernel);
        maps(feature_method_i,sift_type_i) = mAP;
%         results{feature_method_i*sift_type_i} = [map, ap, ranking, ranking_fileName];
    end
end

y = maps;
y
b = bar( y, 'BarWidth', 1);
set(b(1),'FaceColor',[1,0,0])
set(b(2),'FaceColor',[0,1,0])
set(b(3),'FaceColor',[0,0,1])
ylabel('mAP');
set(gca,'xtick',[0.73 0.9 1.1 1.27 1.73 1.9 2.1 2.25])
set(gca,'xticklabel',{'keypoint grayscale','keypoint RGB','keypoint rgb', 'keypoint opponent','dense grayscale','dense RGB','dense rgb', 'dense opponent'})


% celldisp(results)