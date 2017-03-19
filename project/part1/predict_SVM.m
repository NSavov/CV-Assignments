%read model!

feature_dir = strcat('..', filesep, 'Caltech4', filesep, 'FeatureData', filesep);
data_ext = '*.mat';
feature_method = 'keypoint';
sift_type = 'grayscale';
category = 'airplanes_train';

subset_size = 50;

image_categories = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});
% image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);

all_histograms = [];

for category_ind = 1:size(image_categories, 2)
    image_category = char(image_categories(category_ind));
    image_category
    load(strcat(histograms_dir, image_category, '.mat'), 'histograms');
    all_histograms = cat(1, all_histograms, histograms(1:subset_size,:));
end

labels = cat(1, zeros(subset_size, 1), ones(3*subset_size, 1));

 [predicted_label, accuracy, decision_values] = predict(labels, sparse(double(all_histograms)), model);