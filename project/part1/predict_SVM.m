%read model!

histograms_dir = '..\Caltech4\FeatureData\';
data_ext = '*.mat';
feature_method = 'keypoint';
sift_type = 'grayscale';
category = 'airplanes_train';

subset_size = 50;

image_categories = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});
histograms_dir = strcat(histograms_dir, feature_method ,'\', sift_type, '\histograms\');

histograms = [];

for category_ind = 1:1%size(image_categories, 2)
    image_category = char(image_categories(category_ind));
    image_category
    image_category_dir = strcat(histograms_dir, image_category, '\');

    files = dir(fullfile(image_category_dir, data_ext));

    for i = 1:subset_size
        load(strcat(image_category_dir, files(i).name), 'histogram');
        histograms = cat(1, histograms, histogram);
    end
end

labels = cat(ones(subset_size, 1), zeros(3*subset_size, 1));

 [predicted_label, accuracy, decision_values] = predict(labels, sparse(double(histograms)), model);