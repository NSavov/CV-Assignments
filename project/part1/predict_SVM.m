function [mAP, ap, rankings] = predict_SVM(feature_method, sift_type, models, subset_size)
    setup_paths;
    
    image_categories = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});
    % image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});

    histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);

    all_histograms = [];

    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        load(strcat(histograms_dir, image_category, '.mat'), 'histograms');
        all_histograms = cat(1, all_histograms, histograms(1:subset_size,:));
    end

    labels_cat{1} = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
    labels_cat{2} = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
    labels_cat{3} = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
    labels_cat{4} = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

    ap = zeros(1, 4);
    rankings = zeros(size(labels_cat{1},1),4);
    
    for i = 1:size(image_categories, 2)
         [~, d] = predict(models{i}, all_histograms);
         [ap(i), ranking] = get_average_precision(labels_cat{i}, d(:, 2));
         %implement ranking indices to paths convertions here and put it in
         %rankings
         rankings(:, i) = ranking(:,3);
    end
    
     mAP = sum(ap)/4;
     
end