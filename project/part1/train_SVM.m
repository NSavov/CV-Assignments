setup_paths;
subset_size = 150;

image_categories = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
% image_categories = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});

histograms_dir = strcat(feature_dir, feature_method ,filesep, sift_type, filesep, 'histograms', filesep);

all_histograms = [];

for category_ind = 1:size(image_categories, 2)
    image_category = char(image_categories(category_ind));
    image_category
    load(strcat(histograms_dir, image_category, '.mat'), 'histograms');
%     size(histograms)
    all_histograms = cat(1, all_histograms, histograms(start:start+subset_size-1,:));
end

model = {};

labels_cat{1} = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
labels_cat{2} = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
labels_cat{3} = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
labels_cat{4} = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));

for i = 1:size(image_categories, 2)
 model {i} = train(labels_cat{i}, sparse(double(all_histograms)), '-s 1');
end

% labels = cat(1, ones(subset_size, 1), zeros(3*subset_size, 1));
% model {1} = train(labels, sparse(double(all_histograms)), '-s 1');
% 
% labels = cat(1, cat(1, zeros(subset_size, 1), ones(subset_size, 1)), zeros(2*subset_size, 1));
% model{2} = train(labels, sparse(double(all_histograms)), '-s 1');
% 
% labels = cat(1, cat(1, zeros(2*subset_size, 1), ones(subset_size, 1)), zeros(subset_size, 1));
% model{3} = train(labels, sparse(double(all_histograms)), '-s 1');
% 
% labels = cat(1, zeros(3*subset_size, 1), ones(subset_size, 1));
% model{4} = train(labels, sparse(double(all_histograms)), '-s 1');