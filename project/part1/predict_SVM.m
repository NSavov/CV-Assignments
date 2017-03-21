function [mAP, ap, rankings, ranking_file_paths] = predict_SVM(feature_method, sift_type, models, subset_size,hist_file_suffix)
    setup_paths;
    
    image_categories = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});
    % image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});

    histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);

    all_histograms = [];

    file_paths = [];
    
    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category_dir = strcat(image_dir, image_category, filesep);
        load(strcat(histograms_dir, image_category,hist_file_suffix, '.mat'), 'histograms','hist_image_map');
        all_histograms = cat(1, all_histograms, histograms(1:subset_size,:));
        
        for hist_i=1:size(hist_image_map,2)
            file_paths = vertcat( file_paths, string(strcat(image_category_dir, hist_image_map{hist_i}.name)));
        end
        
    end
    
    labels_cat{1} = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
    labels_cat{2} = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
    labels_cat{3} = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
    labels_cat{4} = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

    ap = zeros(1, 4);
    rankings = zeros(size(labels_cat{1},1),4);
    ranking_file_paths = {};
    for i = 1:size(image_categories, 2)
         [~, d] = predict(models{i}, all_histograms);
         [ap(i), ranking] = get_average_precision(labels_cat{i}, d(:, 2));
         %implement ranking indices to paths convertions here and put it in
         %rankings
         ranking_file_paths{i} = file_paths( ranking(:,3), :);
         rankings(:, i) = ranking(:,3);
    end
    ranking_file_paths = {ranking_file_paths};
     mAP = sum(ap)/4;
end