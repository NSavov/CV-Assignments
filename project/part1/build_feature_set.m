function [] = build_feature_set(method, sift_type, sample_size)

    image_dir = strcat('..', filesep, 'Caltech4', filesep, 'ImageData', filesep);
    image_ext = '*.jpg';
    feature_dir = strcat('..', filesep, 'Caltech4', filesep, 'FeatureData', filesep);

    image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});

    % subset_size = 200;

    for category_ind = 1:size(image_categories, 2)
        image_category = char(image_categories(category_ind));
        image_category_dir = strcat(image_dir, image_category, filesep);

        files = dir(fullfile(image_category_dir, image_ext));
        image_category_dir
        for i = 1:size(files,1)
            image = imread(fullfile(image_category_dir, files(i).name));
            if size(image, 3) <= 1
                continue
            end

            [sift] = extract_sift(image, method, sift_type, sample_size);

            save(strcat(feature_dir, method, filesep, sift_type, filesep, image_category, filesep, files(i).name, '.dat'), 'sift');
        end
    end
end