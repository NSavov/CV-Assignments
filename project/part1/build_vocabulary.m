function [] = build_vocabulary(method, sift_type, vocabulary_size, subset_size)
    subset_str = '';

    if nargin == 4
      subset_str = strcat('_', int2str(subset_size));
    end

    setup_paths;
    
    data_ext = '*.mat';

    image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
    all_sift_features = [];

    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category
        image_category_dir = strcat(feature_dir, method, filesep, sift_type, filesep, 'sift', filesep, image_category, filesep);
        files = dir(fullfile(image_category_dir, data_ext));

        if nargin < 4
            subset_size = size(files,1);
        end
        
        for i = 1:subset_size
            load(strcat(image_category_dir, files(i).name), '-mat', 'sift');
            all_sift_features = cat(1, all_sift_features, sift');
        end
    end
    
    [~, C] = kmeans_fast(double(all_sift_features)', vocabulary_size);
    C = C';
    'built C'
    size(C)
    vocabulary_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'vocabulary', filesep);
    mkdir(vocabulary_file_path);
    save(strcat(vocabulary_file_path, 'vocabulary', subset_str), 'C');
end