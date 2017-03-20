function [models] = train_SVM(feature_method, sift_type, start_index, subset_size)
    setup_paths;
    image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
    histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);
    all_histograms = [];

    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        load(strcat(histograms_dir, image_category, '.mat'), 'histograms');
        all_histograms = cat(1, all_histograms, histograms(start_index:start_index+subset_size-1,:));
    end

    models = {};

    labels_cat{1} = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
    labels_cat{2} = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
    labels_cat{3} = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
    labels_cat{4} = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

    for i = 1:size(image_categories, 2)
    %  model{i} = train(labels_cat{i}, sparse(double(all_histograms)), '-s 1');
    %  [w, b] = vl_svmtrain(all_histograms', labels_cat{i}, 0.01,'MaxNumIterations', 1000);
     models{i} = fitcsvm(all_histograms, labels_cat{i},'KernelFunction','linear','ClassNames',[0, 1]);
    end
end