% function [] = build_feature_set(method, sift_type, sample_size)

image_dir = '..\Caltech4\ImageData\';
data_ext = '*.dat';
feature_dir = '..\Caltech4\FeatureData\';

sample_size = 2;
image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
all_sift_features = [];

method = 'keypoint';
sift_type = 'grayscale';
% subset_size = 200;

for category_ind = 1:size(image_categories, 2)
    image_category = char(image_categories(category_ind));
    image_category
    image_category_dir = strcat(feature_dir, method, '\', sift_type, '\', image_category, '\');

    files = dir(fullfile(image_category_dir, data_ext));

    for i = 1:size(files,1)
        
        load(strcat(feature_dir, method, '\', sift_type, '\', image_category, '\', files(i).name), '-mat', 'sift');
        all_sift_features = cat(1, all_sift_features, sift');
    end
end
% end
size(all_sift_features)
[idx, C] = kmeans(double(all_sift_features), 400);
save(strcat(feature_dir, method, '\', sift_type, '\vocabulary\vocabulary'), 'C');