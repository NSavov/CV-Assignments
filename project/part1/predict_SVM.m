function [mAP, ap, rankings, ranking_file_paths] = predict_SVM(feature_method, sift_type, models, subset_size, image_categories, hist_file_suffix)
%used to get the prediction of the SVM for the selected image categories
%(train, test)

    setup_paths;
    
    histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);

    all_histograms = [];
    file_paths = [];
    
    %iterate over all dataset folders
    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category_dir = strcat(image_dir, image_category, filesep);
        
        %load corresponding histograms
        load(strcat(histograms_dir, image_category,hist_file_suffix, '.mat'), 'histograms','hist_image_map');
        all_histograms = cat(1, all_histograms, histograms(1:subset_size,:));
        
        %construct list of image paths stored in the histograms files
        for hist_i=1:size(hist_image_map,2)
            file_paths = vertcat( file_paths, string(strcat(image_category_dir, hist_image_map{hist_i}.name)));
        end
        
    end
    
    %setup true labels(for evaluation) of the selected images
    labels_cat{1} = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
    labels_cat{2} = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
    labels_cat{3} = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
    labels_cat{4} = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

    ap = zeros(1, 4);
    rankings = zeros(size(labels_cat{1},1),4);
    ranking_file_paths = {};
    
    %iterate over each of the classes
    for i = 1:size(image_categories, 2)
        %make predictions for all of the histograms
         [~, d] = predict(models{i}, all_histograms);
         
         %evaluate
         [ap(i), ranking] = get_average_precision(labels_cat{i}, d(:, 2));
         
         %construct ranklist of image filepaths
         ranking_file_paths{i} = file_paths( ranking(:,3), :);
         rankings(:, i) = ranking(:,3);
    end
    
    %prevent from merging the cell array into the results cell array
    ranking_file_paths = {ranking_file_paths};
    
    %compute mAP
     mAP = sum(ap)/4;
end