function [] = build_vocabulary(method, sift_type, vocabulary_size, subset_size)
%used to build a vocabulary with "vocabulary_size" using "subset_size"
%(vocabulary fraction) images' SIFT features of "sift_type", extracted by
%using "method" (keypoint or dense)

    subset_str = '';

    if nargin >= 4
      subset_str = strcat('_', int2str(subset_size));
    end

    suffix = '';
    
    if vocabulary_size ~= 400
        suffix = strcat('_',num2str(vocabulary_size));
    end
    
    setup_paths;
    
    data_ext = '*.mat';

    %always generate vocabulary from the train set
    image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
    all_sift_features = [];

    %iterate over train set fodlers
    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category
        image_category_dir = strcat(feature_dir, method, filesep, sift_type, filesep, 'sift', filesep, image_category, filesep);
        files = dir(fullfile(image_category_dir, data_ext));

        if nargin < 4
            subset_size = size(files,1);
        end
        
        %iterate over SIFT features files
        for i = 1:subset_size
            %load SIFT features for a specified image
            load(strcat(image_category_dir, files(i).name), '-mat', 'sift');
            
            %add it to the collection of all features
            all_sift_features = cat(1, all_sift_features, sift');
        end
    end
    
    %run kmeans algorithm on all of the features
    [~, C] = kmeans_fast(double(all_sift_features)', vocabulary_size);
    C = C';

    %store vocabulary to file
    vocabulary_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'vocabulary', filesep);
    mkdir(vocabulary_file_path);
    save(strcat(vocabulary_file_path, 'vocabulary', subset_str, suffix), 'C');
end