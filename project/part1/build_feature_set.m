function [] = build_feature_set(method, sift_type, sample_size, subset_size)
    
    subset_str = '';

    if nargin == 4
      subset_str = strcat('_', int2str(subset_size));
    end
    
    setup_paths;
    image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});

    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category_dir = strcat(image_dir, image_category, filesep);

        files = dir(fullfile(image_category_dir, image_ext));
        image_category
        
        if nargin < 4
          subset_size = size(files,1);
        end
        
        feature_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'sift', filesep, image_category, filesep);
        mkdir(feature_file_path);
        
        for i = 1:subset_size
            image = imread(fullfile(image_category_dir, files(i).name));
            if size(image, 3) <= 1
                continue
            end

            [sift] = extract_sift(image, method, sift_type, sample_size);
            save(strcat(feature_file_path, files(i).name, subset_str, '.mat'), 'sift');
        end
    end
end