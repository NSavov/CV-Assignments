%read model!

setup_paths;
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

labels_cat_1 = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
labels_cat_2 = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
labels_cat_3 = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
labels_cat_4 = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

ap = zeros(1, 4);
 [predicted_label, accuracy, decision_values] = predict(labels_cat_1, sparse(double(all_histograms)), model{1});
 ap(1) = get_average_precision(labels_cat_1, decision_values);

  [predicted_label, accuracy, decision_values] = predict(labels_cat_2, sparse(double(all_histograms)), model{2});
 ap(2) = get_average_precision(labels_cat_1, decision_values);
 
  [predicted_label, accuracy, decision_values] = predict(labels_cat_3, sparse(double(all_histograms)), model{3});
 ap(3) = get_average_precision(labels_cat_1, decision_values);
 
  [predicted_label, accuracy, decision_values] = predict(labels_cat_4, sparse(double(all_histograms)), model{4});
 ap(4) = get_average_precision(labels_cat_1, decision_values);
 mAP = sum(ap)/4