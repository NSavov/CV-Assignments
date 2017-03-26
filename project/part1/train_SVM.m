function [models] = train_SVM(feature_method, sift_type, kernel, start_index, subset_size, image_categories, hist_file_suffix)
%used to train SVM classifier

    setup_paths;
    histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);
    all_histograms = [];
    
    %iterate over classes and load their histograms
    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        load(strcat(histograms_dir, image_category, hist_file_suffix,'.mat'), 'histograms');
        all_histograms = cat(1, all_histograms, histograms(start_index:start_index+subset_size-1,:));
    end

    models = {};

    %define true labels of separate classifiers
    labels_cat{1} = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
    labels_cat{2} = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
    labels_cat{3} = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
    labels_cat{4} = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

    %train one SVM classifier for each class
    for i = 1:size(image_categories, 2)
        models{i} = fitcsvm(all_histograms, labels_cat{i},'KernelFunction',kernel,'ClassNames',[0, 1]);
    end
end