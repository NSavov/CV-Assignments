function [] = build_vocabulary(method, sift_type, subset_size)
    subset_str = '';

    if nargin == 3
      subset_str = strcat('_', int2str(subset_size));
    end

    setup_paths;
    
    data_ext = '*.mat';

    image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
    all_sift_features = [];

    % subset_size = 200;

    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category
        image_category_dir = strcat(feature_dir, method, '\', sift_type, '\', image_category, '\');

        files = dir(fullfile(image_category_dir, data_ext));

        if nargin < 3
            subset_size = size(files,1);
        end
        
        for i = 1:subset_size

            load(strcat(feature_dir, method, '\', sift_type, '\', image_category, '\', files(i).name), '-mat', 'sift');
            all_sift_features = cat(1, all_sift_features, sift');
        end
    end
    % end
    size(all_sift_features)
    [~, C] = kmeans(double(all_sift_features), 400);
    save(strcat(feature_dir, method, '\', sift_type, '\vocabulary\vocabulary', subset_str), 'C');
end